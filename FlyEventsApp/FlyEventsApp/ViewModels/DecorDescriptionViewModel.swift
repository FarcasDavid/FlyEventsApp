//
//  DecorDescriptionViewModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 13.06.2024.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore

class DecorDescriptionViewModel {

    private let dataBase = Firestore.firestore()
    private var decorDescription: DecorDescription?
    var decorDescriptionModel: DecorDescriptionModel?
    private let dispatchGroup = DispatchGroup()

    func fetchDecorDescription(for id: String, completion: @escaping (DecorDescription?) -> Void) {
        dataBase.collectionGroup("descriptions").whereField("id", isEqualTo: id).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)
                return
            } else {
                if let document = snapshot?.documents.first {
                    if let decorDescription = try? document.data(as: DecorDescription.self) {
                        self.decorDescription = decorDescription
                        completion(decorDescription)
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
        storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
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

    func populateDecorDescriptionModel(with description: DecorDescription, completion: @escaping (Bool) -> Void) {
        var fetchedImages: [UIImage?] = Array(repeating: nil, count: description.imagesURL.count)
        var fetchedCount = 0

        for (index, url) in description.imagesURL.enumerated() {
            dispatchGroup.enter()
            downloadImage(from: url) { image in
                fetchedImages[index] = image
                fetchedCount += 1
                self.dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            if fetchedCount == description.imagesURL.count {
                self.decorDescriptionModel = DecorDescriptionModel(
                    id: description.id,
                    images: fetchedImages
                )
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func getDecorDescription(for id: String, completion: @escaping(Bool) -> Void) {
        fetchDecorDescription(for: id) { description in
            if let description = description {
                self.populateDecorDescriptionModel(with: description) { success in
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    }

}
