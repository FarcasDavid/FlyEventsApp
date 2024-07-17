//
//  CheckoutViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 08.07.2024.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet private weak var checkoutTableView: UITableView!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var submitOrderButton: UIButton!

    private var viewModel = CheckoutViewModel()
    var selectedServices: [ServiceOptionModel] = []
    var totalPrice = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateCheckoutUI()
    }

}
// MARK: UI configuration
extension CheckoutViewController {

    private func setupUI() {
        print("\(totalPrice), \(selectedServices)")
        setBackground()
        setBackButton()
        setNavigationBar()

        totalLabel.font = .coolveticaFont(ofSize: 25, weight: .regular)
        priceLabel.font = .coolveticaFont(ofSize: 25, weight: .regular)
        submitOrderButton.titleLabel?.font = .coolveticaFont(ofSize: 30, weight: .regular)
        submitOrderButton.setTitleColor(.white, for: .normal)
        submitOrderButton.backgroundColor = .darkGray
        submitOrderButton.layer.cornerRadius = 10
    }

    private func updateCheckoutUI() {
        UIView.performWithoutAnimation {
            priceLabel.text = "\(totalPrice) RON"
            self.view.layoutIfNeeded()
        }
    }

}

extension CheckoutViewController {

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

    private func setNavigationBar() {
        self.navigationItem.title = "Checkout"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.coolveticaFont(ofSize: 30, weight: .regular),
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
}

extension CheckoutViewController {

    func setBackground() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "mainBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(backgroundImageView)

        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImageView.bounds
        blurredEffectView.alpha = 0.7
        view.addSubview(blurredEffectView)
        self.view.sendSubviewToBack(blurredEffectView)
        self.view.sendSubviewToBack(backgroundImageView)
    }

}

// MARK: Actions
extension CheckoutViewController {

    @IBAction private func didTapDeleteItem(_ sender: Any) {

    }

    @IBAction private func didTapSubmitOrder(_ sender: Any) {
        viewModel.submitOrder(selectedServices: selectedServices, totalPrice: totalPrice)
        let orderProcessedViewController = OrderProcessedViewController.instantiate()
        orderProcessedViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(orderProcessedViewController, animated: true)
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: Table View Setup
extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedServices.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutCell", for: indexPath) as? CheckoutCell
        let selectedService = selectedServices[indexPath.row]
        cell?.setupCell(with: selectedService, at: indexPath)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}
