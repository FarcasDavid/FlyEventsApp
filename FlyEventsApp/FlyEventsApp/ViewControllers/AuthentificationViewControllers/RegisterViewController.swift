//
//  RegisterViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 10.04.2024.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")

    private let fullnameField = CustomTextField(fieldType: .fullname)
    private let emailField = CustomTextField(fieldType: .email)
    private let phoneNumberField = CustomTextField(fieldType: .phoneNumber)
    private let passwordField = CustomTextField(fieldType: .password)

    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big, type: .login)
    private let signInButton = CustomButton(title: "Already have an account? Sign In.", fontSize: .med)

    private let scrollView = UIScrollView()

    private let termsTextView: UITextView = {

        let attributedString = NSMutableAttributedString(
            string:
            "By creating an account, you agree to our Terms & Conditions "
            +
            "and you acknowledge that you have read our Privacy Policy."
        )
        attributedString.addAttribute(
            .link,
            value: "terms://termsAndConditions",
            range: (attributedString.string as NSString).range(of: "Terms & Conditions")
        )
        attributedString.addAttribute(
            .link,
            value: "privacy://privacyPolicy",
            range: (attributedString.string as NSString).range(of: "Privacy Policy")
        )

        let font = UIFont.coolveticaFont(ofSize: 12, weight: .regular)
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributedString.length))

        let textview = UITextView()
        textview.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        textview.backgroundColor = .clear
        textview.attributedText = attributedString
        textview.textColor = .white
        textview.isSelectable = true
        textview.isEditable = false
        textview.delaysContentTouches = false
        textview.isScrollEnabled = false
        return textview
    }()


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {

        self.termsTextView.delegate = self
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        fullnameField.delegate = self
        emailField.delegate = self
        phoneNumberField.delegate = self
        passwordField.delegate = self


        setBackButton()
        setBackground()

        self.view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        scrollView.addSubview(fullnameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(phoneNumberField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(signUpButton)
        scrollView.addSubview(termsTextView)
        scrollView.addSubview(signInButton)

        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.fullnameField.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.phoneNumberField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.termsTextView.translatesAutoresizingMaskIntoConstraints = false
        self.signInButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), // Adjust if needed
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), // Adjust if needed
            headerView.heightAnchor.constraint(equalToConstant: 222),

            self.fullnameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.fullnameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.fullnameField.heightAnchor.constraint(equalToConstant: 55),
            self.fullnameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.emailField.topAnchor.constraint(equalTo: fullnameField.bottomAnchor, constant: 22),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.phoneNumberField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.phoneNumberField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.phoneNumberField.heightAnchor.constraint(equalToConstant: 55),
            self.phoneNumberField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.passwordField.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 22),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            self.signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 6),
            self.termsTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.termsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 11),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 44),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            signInButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -250)
        ])
    }

    // MARK: - Selectors
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapSignUp() {
        let registerUserRequest = RegisterUserRequest(
            fullname: self.fullnameField.text ?? "",
            email: self.emailField.text ?? "",
            phoneNumber: self.phoneNumberField.text ?? "",
            password: self.passwordField.text ?? ""
        )

        // Email Check
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        // Phone Number Check
        if !Validator.isValidPhoneNumber(for: registerUserRequest.phoneNumber) {
            AlertManager.showInvalidPhoneNumberAlert(on: self)
            return
        }

        // Password Check
        if !Validator.isValidPassword(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }

            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }

            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }

    @objc private func didTapSignIn() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension RegisterViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {

        if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=en")
        } else if URL.scheme == "privacy" {
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=en")
        }
        return true
    }

    private func showWebViewerController(with urlString: String) {
        let viewcontroller = TermsAndPrivacyViewController(with: urlString)
        let nav = UINavigationController(rootViewController: viewcontroller)
        self.present(nav, animated: true, completion: nil)
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}

extension RegisterViewController {

    private func setBackground() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "mainBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(backgroundImageView)
      //  self.view.sendSubviewToBack(backgroundImageView)

        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImageView.bounds
        blurredEffectView.alpha = 0.7
        view.addSubview(blurredEffectView)
    }

    private func setBackButton() {
        let backButtonImage = UIImage(named: "CustomBackNavIcon")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(didTapBack)
        )
        navigationItem.leftBarButtonItem = backButton
    }

}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
