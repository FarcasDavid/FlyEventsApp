//
//  CustomButton.swift
//  FlyEventsApp
//
//  Created by David Farcas on 10.04.2024.
//

import UIKit

class CustomButton: UIButton {

    enum FontSize {
        case big
        case med
        case small
    }
    enum ButtonType {
        case login
        case logout
        case regular
    }

    private var gradientLayer: CAGradientLayer?

    init(title: String, hasBackground: Bool = false, fontSize: FontSize, type: ButtonType = .regular) {
        super.init(frame: .zero)


        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true

        if hasBackground {
            switch type {
            case .login:
                applyLoginGradient()
                setAttributedTitle(title: title, icon: UIImage(named: "LoginIcon"), size: 22, height: -4)
            case .logout:
                // applyLogoutGradient()
                setAttributedTitle(title: title, icon: UIImage(named: "LogoutIcon"), size: 16, height: -2)
            case .regular:
                self.backgroundColor = .systemBlue
            }
        } else {
            self.backgroundColor = .clear
        }

        let titleColor: UIColor = hasBackground ? .white : .lightText
        self.setTitleColor(titleColor, for: .normal)

        switch fontSize {
        case .big:
            self.titleLabel?.font = .coolveticaFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .coolveticaFont(ofSize: 18, weight: .regular)
        case .small:
            self.titleLabel?.font = .coolveticaFont(ofSize: 18, weight: .light)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer?.frame = bounds
    }

    private func applyLoginGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor(
                red: 0 / 255,
                green: 97 / 255,
                blue: 255 / 255,
                alpha: 1.0
            ).cgColor,
            UIColor(
                red: 96 / 255,
                green: 239 / 255,
                blue: 255 / 255,
                alpha: 1.0
            ).cgColor
        ]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer?.cornerRadius = layer.cornerRadius
        gradientLayer?.frame = bounds
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    private func setAttributedTitle(title: String, icon: UIImage?, size: Int, height: Int) {
        let attributedString = NSMutableAttributedString()

        if let icon = icon {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = icon
            imageAttachment.bounds = CGRect(
                x: 0,
                y: height,
                width: size,
                height: size
            )
            let imageString = NSAttributedString(attachment: imageAttachment)
            attributedString.append(imageString)
            attributedString.append(NSAttributedString(string: " "))
        }

        let titleString = NSAttributedString(string: title)
        attributedString.append(titleString)
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
