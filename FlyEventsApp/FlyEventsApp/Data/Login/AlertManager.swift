//
//  AlertManager.swift
//  FlyEventsApp
//
//  Created by David Farcas on 12.04.2024.
//

import UIKit

class AlertManager {
    private static func showBasicAlert(on viewcontroller: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            viewcontroller.present(alert, animated: true)
        }
    }

    private static func showTextFieldAlert(
        on viewController: UIViewController,
        title: String,
        completion: @escaping (Int?) -> Void
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: "Please enter only digits",
                preferredStyle: .alert
            )
            alert.overrideUserInterfaceStyle = .dark
            alert.addTextField { textField in
                textField.keyboardType = .numberPad
            }
            alert.addAction(
                UIAlertAction(
                    title: "Cancel",
                    style: .default,
                    handler: { _ in
                        completion(nil)
                    }
                )
            )
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: { [weak alert] _ in
                        if let textField = alert?.textFields?.first, let text = textField.text, let number = Int(text) {
                            completion(number)
                        } else {
                            completion(nil)
                        }
                    }
                )
            )
            viewController.present(alert, animated: true)
        }
    }

}

// MARK: - Validation Alerts
extension AlertManager {

    public static func showInvalidEmailAlert(on viewcontroller: UIViewController) {
        self.showBasicAlert(on: viewcontroller, title: "Invalid Email", message: "Please enter a valid email.")
    }

    public static func showInvalidPasswordAlert(on viewcontroller: UIViewController) {
        self.showBasicAlert(on: viewcontroller, title: "Invalid Password", message: "Please enter a valid password.")
    }

    public static func showInvalidPhoneNumberAlert(on viewcontroller: UIViewController) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Invalid Phone Number",
            message: "Please enter a 10 digit phone number, starting with 07."
        )
    }

}


// MARK: - Registration Errors
extension AlertManager {

    public static func showRegistrationErrorAlert(on viewcontroller: UIViewController) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Unknown Registration Error",
            message: nil
        )
    }

    public static func showRegistrationErrorAlert(on viewcontroller: UIViewController, with error: Error) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Registration Error",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Log In Errors
extension AlertManager {

    public static func showSignInErrorAlert(on viewcontroller: UIViewController) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Unknown Error Signing In",
            message: nil
        )
    }

    public static func showSignInErrorAlert(on viewcontroller: UIViewController, with error: Error) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Unknown Error Signing In",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Log Out Errors
extension AlertManager {

    public static func showLogoutErrorAlert(on viewcontroller: UIViewController, with error: Error) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Log Out Error",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Forgot Password
extension AlertManager {

    public static func showPasswordResetSent(on viewcontroller: UIViewController) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Password Reset Sent",
            message: nil
        )
    }

    public static func showErrorSendingPasswordReset(on viewcontroller: UIViewController, with error: Error) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Error Sending Password Reset",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Fetching User Errors
extension AlertManager {

    public static func showUnknownFetchingUserError(on viewcontroller: UIViewController) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Unknown Error Fetching User",
            message: nil
        )
    }

    public static func showFetchingUserError(on viewcontroller: UIViewController, with error: Error) {
        self.showBasicAlert(
            on: viewcontroller,
            title: "Error Fetching User",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Number of people for Bar alert
extension AlertManager {

    public static func barNumberOfPeopleAlert(
        on viewcontroller: UIViewController,
        completion: @escaping (Int?) -> Void) {
        self.showTextFieldAlert(
            on: viewcontroller,
            title: "Enter the number of people attending:"
        ) { number in
            completion(number)
        }
    }
}
