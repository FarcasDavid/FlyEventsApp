//
//  HomeViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 15.02.2024.
//

import UIKit

class ChooseEventViewController: UIViewController {


    @IBOutlet private weak var chooseEventView: UIVisualEffectView!
    @IBOutlet private weak var weddingImageView: UIImageView!
    @IBOutlet private weak var baptismImageView: UIImageView!
    @IBOutlet private weak var birthdayImageView: UIImageView!
    @IBOutlet private weak var corporateImageView: UIImageView!

    private let logoutButton = CustomButton(
        title: "Logout",
        hasBackground: true,
        fontSize: .med,
        type: .logout
        )

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

    }

    // MARK: - UI Setup
    private func setupUI() {
        chooseEventView.layer.cornerRadius = 30
        chooseEventView.clipsToBounds = true

        weddingImageView.layer.cornerRadius = 15
        weddingImageView.clipsToBounds = true

        baptismImageView.layer.cornerRadius = 15
        baptismImageView.clipsToBounds = true

        birthdayImageView.layer.cornerRadius = 15
        birthdayImageView.clipsToBounds = true

        corporateImageView.layer.cornerRadius = 15
        corporateImageView.clipsToBounds = true


        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: logoutButton
        )

        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

        ])

    }

}
// MARK: - Actions
extension ChooseEventViewController {

    @IBAction private func didTapWedding(_ sender: UITapGestureRecognizer) {
        goToServicesViewController(for: .wedding)
    }
    @IBAction private func didTapBaptism(_ sender: UITapGestureRecognizer) {
        goToServicesViewController(for: .baptising)
    }
    @IBAction private func didTapBirthday(_ sender: UITapGestureRecognizer) {
        goToServicesViewController(for: .majorat)
    }
    @IBAction private func didTapCorporate(_ sender: UITapGestureRecognizer) {
        goToServicesViewController(for: .corporate)
    }

// MARK: - Selectors
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                AlertManager.showLogoutErrorAlert(on: self, with: error)
                return
            }

            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }

}

// MARK: - Segues
extension ChooseEventViewController {

    func goToServicesViewController(for event: Event) {
        let servicesViewController = ServicesViewController.instantiate()
        servicesViewController.event = event
        navigationController?.pushViewController(servicesViewController, animated: true)
    }

}
