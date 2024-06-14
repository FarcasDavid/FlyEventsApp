//
//  DjDescriptionViewModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 11.06.2024.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore

class DjDescriptionViewModel {

    private let dataBase = Firestore.firestore()
    private var djDescription: DjDescription?
    var djDescriptionModel: DjDescriptionModel?

    func fetchDjDescription(for id: String, completion: @escaping (DjDescription?) -> Void) {
        dataBase.collectionGroup("descriptions").whereField("id", isEqualTo: id).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)
                return
            } else {
                if let document = snapshot?.documents.first {
                    if let djDescription = try? document.data(as: DjDescription.self) {
                        self.djDescription = djDescription
                        completion(djDescription)
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

    func populateDjDescriptionModel(with description: DjDescription, completion: @escaping (Bool) -> Void) {
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

                self.djDescriptionModel = DjDescriptionModel(
                    backgroundImage: backgroundImage,
                    id: description.id,
                    image: image,
                    numberOfPeople: description.numberOfPeople,
                    packDescription: description.packDescription,
                    price: description.price,
                    title: description.title
                )
                completion(true)
            }
        }
    }

    func getDjDescription(for id: String, completion: @escaping(Bool) -> Void) {
        fetchDjDescription(for: id) { description in
            if let description = description {
                self.populateDjDescriptionModel(with: description) { success in
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    }
}
