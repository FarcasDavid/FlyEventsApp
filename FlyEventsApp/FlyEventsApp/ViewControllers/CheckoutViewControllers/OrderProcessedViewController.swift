//
//  OrderProcessedViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 17.07.2024.
//

import UIKit

class OrderProcessedViewController: UIViewController {
    @IBOutlet private weak var orderSentLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setBackground()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func setupUI() {
        orderSentLabel.font = .coolveticaFont(ofSize: 25, weight: .bold)
        backButton.titleLabel?.font = .coolveticaFont(ofSize: 20, weight: .regular)
        backButton.setTitleColor(.lightGray, for: .normal)
    }

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

extension OrderProcessedViewController {
    @IBAction private func didTapBack(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
