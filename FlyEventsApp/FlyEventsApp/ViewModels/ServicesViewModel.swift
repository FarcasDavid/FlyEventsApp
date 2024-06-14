//
//  ChooseEventViewModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 30.05.2024.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore

class ServicesViewModel {

    private let dataBase = Firestore.firestore()
    private let dispatchGroup = DispatchGroup()
    private var serviceOptions: [ServiceOptions] = []
    private var serviceOptionsDJ: [ServiceOptionModel] = []
    private var serviceOptionsBar: [ServiceOptionModel] = []
    private var serviceOptionsFoto: [ServiceOptionModel] = []
    private var serviceOptionsDecor: [ServiceOptionModel] = []
    var servicesSections: [[ServiceOptionModel]] = []

    func fetchServices(for event: String, completion: @escaping ([ServiceOptions]) -> Void) {
        dataBase.collectionGroup("options").whereField("event", isEqualTo: event).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                completion([])
                return
            } else {
                for document in snapshot?.documents ?? [] {
                    if let serviceOption = try? document.data(as: ServiceOptions.self) {
                        self.serviceOptions.append(serviceOption)
                    }
                }
            }
            completion(self.serviceOptions)
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

    func populateServicesModels(with services: [ServiceOptions], completion: @escaping (Bool) -> Void) {
        for service in services {
            self.dispatchGroup.enter()
            switch service.service {
            case "DJ":
                downloadImage(from: service.imageURL) { image in
                    if let image = image {
                        let serviceOptionModel = ServiceOptionModel(
                            title: service.title,
                            price: service.price,
                            event: service.event,
                            service: service.service,
                            image: image,
                            id: service.id
                        )
                        self.serviceOptionsDJ.append(serviceOptionModel)
                    }
                    self.dispatchGroup.leave()
                }
            case "BAR":
                downloadImage(from: service.imageURL) { image in
                    if let image = image {
                        let serviceOptionModel = ServiceOptionModel(
                            title: service.title,
                            price: service.price,
                            event: service.event,
                            service: service.service,
                            image: image,
                            id: service.id
                        )
                        self.serviceOptionsBar.append(serviceOptionModel)
                    }
                    self.dispatchGroup.leave()
                }
            case "FOTO":
                downloadImage(from: service.imageURL) { image in
                    if let image = image {
                        let serviceOptionModel = ServiceOptionModel(
                            title: service.title,
                            price: service.price,
                            event: service.event,
                            service: service.service,
                            image: image,
                            id: service.id
                        )
                        self.serviceOptionsFoto.append(serviceOptionModel)
                    }
                    self.dispatchGroup.leave()
                }
            case "DECOR":
                downloadImage(from: service.imageURL) { image in
                    if let image = image {
                        let serviceOptionModel = ServiceOptionModel(
                            title: service.title,
                            price: service.price,
                            event: service.event,
                            service: service.service,
                            image: image,
                            id: service.id
                        )
                        self.serviceOptionsDecor.append(serviceOptionModel)
                    }
                    self.dispatchGroup.leave()
                }
            default:
                self.dispatchGroup.leave()
            }
        }
        self.dispatchGroup.notify(queue: .main) {
            self.serviceOptionsDJ.sort {
                $0.price < $1.price
            }
            self.serviceOptionsBar.sort {
                $0.price < $1.price
            }
            self.serviceOptionsFoto.sort {
                $0.price < $1.price
            }
            self.serviceOptionsDecor.sort {
                $0.title < $1.title
            }
            self.servicesSections = [
                self.serviceOptionsDJ,
                self.serviceOptionsBar,
                self.serviceOptionsFoto,
                self.serviceOptionsDecor
            ]
            completion(true)
        }
    }

    func getServices(from event: Event, completion: @escaping (Bool) -> Void) {
        fetchServices(for: event.rawValue) { services in
            self.populateServicesModels(with: services) { success in
                completion(success)
            }
        }
    }

}
