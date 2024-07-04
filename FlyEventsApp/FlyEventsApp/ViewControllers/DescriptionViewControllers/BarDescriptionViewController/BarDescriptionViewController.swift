//
//  BarDescriptionViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 02.06.2024.
//

import UIKit

class BarDescriptionViewController: UIViewController {

    @IBOutlet private weak var backgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var titleBackground: UIVisualEffectView!
    @IBOutlet private weak var descriptionTitle: UILabel!
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var priceTitleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var packIncludesLabel: UILabel!
    @IBOutlet private weak var priceBackgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var packDescriptionLabel: UILabel!
    @IBOutlet private weak var descriptionBackgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var packDescriptionTitleLabel: UILabel!

    private var viewModel = BarDescriptionViewModel()
    var id: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        loadAllData()
        setupUI()
    }

}

extension BarDescriptionViewController {

    private func setupUI() {
        backgroundBlur.layer.cornerRadius = 20
        backgroundBlur.clipsToBounds = true

        titleBackground.layer.cornerRadius = 20
        titleBackground.clipsToBounds = true

        pictureView.layer.cornerRadius = 20
        pictureView.clipsToBounds = true

        descriptionBackgroundBlur.layer.cornerRadius = 20
        descriptionBackgroundBlur.clipsToBounds = true

        descriptionTitle.font = .coolveticaFont(ofSize: 35, weight: .regular)

        priceBackgroundBlur.layer.cornerRadius = 20
        priceBackgroundBlur.clipsToBounds = true

        priceTitleLabel.font = .coolveticaFont(ofSize: 15, weight: .regular)
        priceTitleLabel.textColor = UIColor(white: 1.0, alpha: 0.5)

        priceLabel.font = .coolveticaFont(ofSize: 30, weight: .regular)

        packIncludesLabel.font = .coolveticaFont(ofSize: 15, weight: .regular)
        packIncludesLabel.textColor = UIColor(white: 1.0, alpha: 0.5)

        packDescriptionLabel.font = .coolveticaFont(ofSize: 15, weight: .regular)

        packDescriptionTitleLabel.font = .coolveticaFont(ofSize: 20, weight: .regular)
        packDescriptionTitleLabel.text = packDescriptionTitleLabel.text?.uppercased()
    }
}

    extension BarDescriptionViewController {

        private func loadAllData() {
            viewModel.getBarDescription(for: id) { isLoaded in
                if isLoaded {
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                }
            }
        }

    }

    extension BarDescriptionViewController {

        private func updateUI() {
            descriptionTitle.text = viewModel.barDescriptionModel?.title.uppercased()
            priceLabel.text = viewModel.barDescriptionModel?.priceWithCurrency
            pictureView.image = viewModel.barDescriptionModel?.image
            packDescriptionTitleLabel.text =
            viewModel.barDescriptionModel?.packDescriptionTitle.replacingOccurrences(of: "\\n", with: "\n")
            packDescriptionLabel.text =
            viewModel.barDescriptionModel?.packDescription.replacingOccurrences(of: "\\n", with: "\n")
            setBackground()
        }

        func setBackground() {
            let backgroundImageView = UIImageView(frame: self.view.bounds)
            backgroundImageView.image = viewModel.barDescriptionModel?.backgroundImage
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(backgroundImageView)
            self.view.sendSubviewToBack(backgroundImageView)
        }
    }
