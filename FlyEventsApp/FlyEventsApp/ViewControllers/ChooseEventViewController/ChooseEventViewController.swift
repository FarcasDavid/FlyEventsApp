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

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
    }

}
// MARK: - Actions
extension ChooseEventViewController {

    @IBAction private func didTapWedding(_ sender: UITapGestureRecognizer) {
        print("did tap wedding")
//        viewModel.getServices(from: "wedding")
        goToServicesViewController(for: .wedding)
    }
    @IBAction private func didTapBaptism(_ sender: UITapGestureRecognizer) {
        print("did tap baptism")
//        viewModel.getServices(from: "botez")
        goToServicesViewController(for: .baptising)
    }
    @IBAction private func didTapBirthday(_ sender: UITapGestureRecognizer) {
        print("did tap majorat")
//        viewModel.getServices(from: "majorat")
        goToServicesViewController(for: .majorat)
    }
    @IBAction private func didTapCorporate(_ sender: UITapGestureRecognizer) {
        print("did tap corporate")
//                viewModel.getServices(from: "corporate")
        goToServicesViewController(for: .corporate)
    }

    @objc private func didTapLogout() {
        // TODO: Create function for logic here in viewModel
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
