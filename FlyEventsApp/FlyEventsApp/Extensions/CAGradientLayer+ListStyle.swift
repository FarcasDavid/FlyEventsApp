//
//  CAGradientLayer+ListStyle.swift
//  FlyEventsApp
//
//  Created by David Farcas on 02.07.2024.
//

import Foundation
import UIKit

// enum AuthStyle {
//    case login
//    case logout
// }
// extension CAGradientLayer {
//    static func gradientLayer(for style: AuthStyle, in frame: CGRect) -> Self {
//        let layer = Self()
//        layer.colors = colors(for: style)
//        layer.frame = frame
//        return layer
//    }
//    private static func colors(for style: AuthStyle) -> [CGColor] {
//        let beginColor: UIColor
//        let endColor: UIColor
//
//
//        switch style {
//        case .login:
//            beginColor = UIColor(red: 0, green: 97, blue: 255, alpha: 1.0)
//            endColor = UIColor(red: 96, green: 239, blue: 255, alpha: 1.0)
//        case .logout:
//            beginColor = UIColor(red: 255, green: 15, blue: 123, alpha: 1.0)
//            endColor = UIColor(red: 248, green: 155, blue: 41, alpha: 1.0)
//        }
//        return [beginColor.cgColor, endColor.cgColor]
//    }
// }
// extension UIButton {
//
//    func applyLoginGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor(red: 0, green: 97, blue: 255, alpha: 1.0),
//            UIColor(red: 96, green: 239, blue: 255, alpha: 1.0)
//        ]
//        gradientLayer.cornerRadius = layer.cornerRadius
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
//        gradientLayer.frame = bounds
//        layer.insertSublayer(gradientLayer, at: 0)
//    }
// }
