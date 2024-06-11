//
//  OptionsModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 23.05.2024.
//

import Foundation

struct ServiceOptions: Codable {

    enum CodingKeys: String, CodingKey {
        case title
        case price
        case event
        case service
        case imageURL
        case id
    }

    let title: String
    let price: Int
    let event: String
    let service: String
    let imageURL: String
    let id: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.price = try container.decode(Int.self, forKey: .price)
        self.event = try container.decode(String.self, forKey: .event)
        self.service = try container.decode(String.self, forKey: .service)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.id = try container.decode(String.self, forKey: .id)
    }
}
