//
//  CheckoutViewModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 17.07.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class CheckoutViewModel {
    private let dataBase = Firestore.firestore()

    func submitOrder(selectedServices: [ServiceOptionModel], totalPrice: Int) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }

        let usersReference = dataBase.collection("users").document(userUID)

        usersReference.getDocument { document, error in
            if let document = document, document.exists {
                let userFullName = document.data()?["fullname"] as? String ?? ""
                let userPhoneNumber = document.data()?["phoneNumber"] as? String ?? ""
                let userEmail = document.data()?["email"] as? String ?? ""
                let selectedServicesTitles = selectedServices.map { $0.title }

                let orderData: [String: Any] = [
                    "fullName": userFullName,
                    "phoneNumber": userPhoneNumber,
                    "email": userEmail,
                    "selectedServices": selectedServicesTitles,
                    "totalPrice": totalPrice
                ]

                self.dataBase.collection("orders").addDocument(data: orderData) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Order document added successfully.")
                    }
                }

            } else {
                print("User document does not exist.")
            }
        }
    }
}
