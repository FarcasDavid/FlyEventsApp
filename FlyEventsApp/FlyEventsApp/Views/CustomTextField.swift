//
//  CustomTextField.swift
//  FlyEventsApp
//
//  Created by David Farcas on 10.04.2024.
//

import UIKit

class CustomTextField: UITextField {

    enum CustomTextFieldType {
        case fullname
        case email
        case phoneNumber
        case password
    }

    private let authFieldType: CustomTextFieldType

    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)

        self.backgroundColor = .darkGray
        self.textColor = .white
        self.layer.cornerRadius = 10
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none

        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))

        switch fieldType {
        case .fullname:
            self.placeholder = "Full Name"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.coolveticaFont(ofSize: 19, weight: .light)
                ]
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
            self.font = UIFont.coolveticaFont(ofSize: 19, weight: .light)
        case .password:
            self.placeholder = "Password"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.coolveticaFont(ofSize: 19, weight: .light)
                ]
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        case .email:
            self.placeholder = "Email Address"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.coolveticaFont(ofSize: 19, weight: .light)
                ]
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
            self.font = UIFont.coolveticaFont(ofSize: 19, weight: .light)
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .phoneNumber:
            self.placeholder = "Phone Number"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.coolveticaFont(ofSize: 19, weight: .light)
                ]
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
            self.font = UIFont.coolveticaFont(ofSize: 19, weight: .light)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
