//
//  ServiceOptionModel.swift
//  FlyEventsApp
//
//  Created by David Farcas on 25.05.2024.
//

import Foundation
import UIKit

struct ServiceOptionModel {

    let title: String
    let price: Int
    let event: String
    let service: String
    let image: UIImage?
    let id: String

    var priceWithCurrency: String {
        if service == "BAR" {
            return "\(price) RON / PERSON"
        } else {
            return "\(price) RON"
        }
    }

}
