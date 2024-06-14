//
//  BarDescriptionViewModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 13.06.2024.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore

class BarDescriptionViewModel {

    private let dataBase = Firestore.firestore()
    private var barDescription: BarDescription?
    var barDescriptionModel: BarDescriptionModel?

    func fetchBarDescription(for id: String, completion: @escaping (BarDescription?) -> Void) {
        dataBase.collectionGroup("descriptions").whereField("id", isEqualTo: id).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)
                return
            } else {
                if let document = snapshot?.documents.first {
                    if let barDescription = try? document.data(as: BarDescription.self) {
                        self.barDescription = barDescription
                        completion(barDescription)
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

    func populateBarDescriptionModel(with description: BarDescription, completion: @escaping (Bool) -> Void) {
        downloadImage(from: description.backgroundImageURL) { backgroundImage in
            guard let backgroundImage = backgroundImage else {
                completion(false)
                return
            }

            self.downloadImage(from: description.imageURL) { image in
                guard let image = image else {
                    completion(false)
                    return
                }

                self.barDescriptionModel = BarDescriptionModel(
                    backgroundImage: backgroundImage,
                    id: description.id,
                    image: image,
                    packDescriptionTitle: description.packDescriptionTitle,
                    packDescription: description.packDescription,
                    price: description.price,
                    title: description.title
                )
                completion(true)
            }
        }
    }

    func getBarDescription(for id: String, completion: @escaping(Bool) -> Void) {
        fetchBarDescription(for: id) { description in
            if let description = description {
                self.populateBarDescriptionModel(with: description) { success in
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    }

}
