//
//  AuthService.swift
//  FlyEventsApp
//
//  Created by David Farcas on 12.04.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

public class AuthService {

    public static let shared = AuthService()

    private init() {}


    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The users information (email, password, phone number, full name)
    ///   - completion: A completion with two values...
    ///   - Bool: wasRegistered - Determines if the user was registered and saved in the database correctly
    ///   - Error?: An optional error if firebase provides once
    func registerUser(
        with userRequest: RegisterUserRequest,
        completion: @escaping (Bool, Error?) -> Void) {
        let fullname = userRequest.fullname
        let email = userRequest.email
        let phoneNumber = userRequest.phoneNumber
        let password = userRequest.password

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }

            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }

            let dataBase = Firestore.firestore()
            dataBase.collection("users")
                .document(resultUser.uid)
                .setData([
                    "fullname": fullname,
                    "phoneNumber": phoneNumber,
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }

                    completion(true, nil)
                }
        }
    }

    func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {

        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { _, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }

    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }

    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }

    func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }

        let dataBase = Firestore.firestore()

        dataBase.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }

                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let fullname = snapshotData["fullname"] as? String,
                   let phoneNumber = snapshotData["phoneNumber"] as? String,
                   let email = snapshotData["email"] as? String {

                    let user = User(fullname: fullname, email: email, phoneNumber: phoneNumber, userUID: userUID)
                    completion(user, nil)
                }
            }
    }
}
