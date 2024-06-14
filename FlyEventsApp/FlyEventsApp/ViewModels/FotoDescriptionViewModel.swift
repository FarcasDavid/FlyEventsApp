//
//  FotoViewModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 13.06.2024.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

class FotoDescriptionViewModel {

    private let dataBase = Firestore.firestore()
    private var fotoDescription: FotoDescription?
    var fotoDescriptionModel: FotoDescriptionModel?

    func fetchFotoDescription(for id: String, completion: @escaping (FotoDescription?) -> Void) {
        dataBase.collectionGroup("descriptions").whereField("id", isEqualTo: id).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)
                return
            } else {
                if let document = snapshot?.documents.first {
                    if let fotoDescription = try? document.data(as: FotoDescription.self) {
                        self.fotoDescription = fotoDescription
                        completion(fotoDescription)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }

    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: url)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
            } else {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }

    func populateFotoDescriptionModel(with description: FotoDescription, completion: @escaping (Bool) -> Void) {
        downloadImage(from: description.imageURL) { image in
            guard let image = image else {
                completion(false)
                return
            }

                self.fotoDescriptionModel = FotoDescriptionModel(
                    id: description.id,
                    image: image
                )
                completion(true)
            }
        }


    func getFotoDescription(for id: String, completion: @escaping(Bool) -> Void) {
        fetchFotoDescription(for: id) { description in
            if let description = description {
                self.populateFotoDescriptionModel(with: description) { success in
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    }

}
