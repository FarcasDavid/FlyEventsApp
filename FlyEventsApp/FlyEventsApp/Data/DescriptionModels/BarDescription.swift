//
//  BarDescription.swift
//  FlyEventsApp
//
//  Created by David Farcas on 11.06.2024.
//

import Foundation

struct BarDescription: Codable {

    enum CodingKeys: String, CodingKey {
        case backgroundImageURL
        case id
        case imageURL
        case packDescriptionTitle
        case packDescription
        case price
        case title
    }

    let backgroundImageURL: String
    let id: String
    let imageURL: String
    let packDescriptionTitle: String
    let packDescription: String
    let price: Int
    let title: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backgroundImageURL = try container.decode(String.self, forKey: .backgroundImageURL)
        self.id = try container.decode(String.self, forKey: .id)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.packDescriptionTitle = try container.decode(String.self, forKey: .packDescriptionTitle)
        self.packDescription = try container.decode(String.self, forKey: .packDescription)
        self.price = try container.decode(Int.self, forKey: .price)
        self.title = try container.decode(String.self, forKey: .title)
    }

}
