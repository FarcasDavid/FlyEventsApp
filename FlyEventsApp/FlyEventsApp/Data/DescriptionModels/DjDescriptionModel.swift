//
//  DjDescriptionModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 11.06.2024.
//

import Foundation
import UIKit

struct DjDescriptionModel {

    let backgroundImage: UIImage?
    let id: String
    let image: UIImage?
    let numberOfPeople: String
    let packDescription: String
    let price: Int
    let title: String

    var priceWithCurrency: String {
        return "\(price) RON"
    }

}
