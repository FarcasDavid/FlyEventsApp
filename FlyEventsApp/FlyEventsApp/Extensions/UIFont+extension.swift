//
//  UIFont+extension.swift
//  FlyEventsApp
//
//  Created by David Farcas on 03.06.2024.
//

import Foundation
import UIKit

extension UIFont {

    class func coolveticaRegular(ofSize fontSize: CGFloat) -> UIFont {
        customFont(name: "CoolveticaRg-Regular", size: fontSize)
    }

    private class func customFont(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }

}
