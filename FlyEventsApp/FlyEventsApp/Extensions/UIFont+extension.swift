//
//  UIFont+extension.swift
//  FlyEventsApp
//
//  Created by David Farcas on 03.06.2024.
//

import Foundation
import UIKit

enum FontWeight {
    case bold
    case regular
    case light
    case extraLight
}

extension UIFont {

    class func coolveticaFont(ofSize fontSize: CGFloat, weight: FontWeight) -> UIFont {
        switch weight {
        case .bold:
            customFont(name: "CoolveticaRg-Bold", size: fontSize)
        case .regular:
            customFont(name: "CoolveticaRg-Regular", size: fontSize)
        case .light:
            customFont(name: "CoolveticaLt-Regular", size: fontSize)
        case .extraLight:
            customFont(name: "CoolveticaEl-Regular", size: fontSize)

        }

    }

    private class func customFont(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }

}
