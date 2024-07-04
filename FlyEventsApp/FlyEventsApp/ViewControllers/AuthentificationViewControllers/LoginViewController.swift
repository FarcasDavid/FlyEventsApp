//
//  LoginViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 10.04.2024.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")

    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)

    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big, type: .login)
    private let newUserButton = CustomButton(title: "New User? Create Account.", fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)

    private let scrollView = UIScrollView()


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

    }

    private func setupUI() {

        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        emailField.delegate = self
        passwordField.delegate = self


        setBackground()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        self.view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(signInButton)
        scrollView.addSubview(newUserButton)
        scrollView.addSubview(forgotPasswordButton)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), // Adjust if needed
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), // Adjust if needed
            headerView.heightAnchor.constraint(equalToConstant: 222),

            emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            emailField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),

            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            passwordField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),

            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            signInButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            signInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),

            newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 11),
            newUserButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            newUserButton.heightAnchor.constraint(equalToConstant: 44),
            newUserButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),

            forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 6),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            forgotPasswordButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),

            // Adjust how much you can scroll
            forgotPasswordButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -400)

        ])
    }

    // MARK: - Selectors
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc private func didTapSignIn() {

        let loginRequest = LoginUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        // Email Check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        // Password Check
        if !Validator.isValidPassword(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }

        AuthService.shared.signIn(with: loginRequest) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
            } else {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                } else {
                    AlertManager.showSignInErrorAlert(on: self)
                }
            }

        }
    }
    @objc private func didTapNewUser() {
        let viewcontroller = RegisterViewController()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    @objc private func didTapForgotPassword() {
        let viewcontroller = ForgotPasswordViewController()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }

}

extension LoginViewController {

    func setBackground() {
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

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
