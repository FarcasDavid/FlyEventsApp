//
//  DjAndBarDescriptionViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 02.06.2024.
//

import Foundation
import UIKit

class DjDescriptionViewController: UIViewController {

    @IBOutlet private weak var titleBackgroundView: UIView!
    @IBOutlet private weak var backgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var titleBackground: UIVisualEffectView!
    @IBOutlet private weak var descriptionTitle: UILabel!
    @IBOutlet private weak var priceTitleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var packPriceView: UIView!
    @IBOutlet private weak var numberOfPeopleView: UIView!
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var numberOfPeopleTitleLabel: UILabel!
    @IBOutlet private weak var numberOfPeopleLabel: UILabel!
    @IBOutlet private weak var priceBackgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var numberOfPeopleBackgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var packDescriptionLabel: UILabel!
    @IBOutlet private weak var packIncludesLabel: UILabel!
    @IBOutlet private weak var descriptionBackgroundBlur: UIVisualEffectView!

    private let viewModel = DjDescriptionViewModel()
    var id: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        loadAllData()
        setupUI()
    }

}

extension DjDescriptionViewController {

    private func setupUI() {
      //  backgroundBlur.backgroundColor = UIColor(red: 114, green: 193, blue: 126, alpha: 0.5)
        backgroundBlur.layer.cornerRadius = 20
        backgroundBlur.clipsToBounds = true

        titleBackground.layer.cornerRadius = 20
        titleBackground.clipsToBounds = true

        titleBackgroundView.layer.cornerRadius = 20
        titleBackgroundView.clipsToBounds = true

        pictureView.layer.cornerRadius = 20
        pictureView.clipsToBounds = true

        descriptionBackgroundBlur.layer.cornerRadius = 20
        descriptionBackgroundBlur.clipsToBounds = true

        descriptionTitle.font = .coolveticaRegular(ofSize: 35)

        packPriceView.backgroundColor = .clear
        priceBackgroundBlur.layer.cornerRadius = 20
        priceBackgroundBlur.clipsToBounds = true

        priceTitleLabel.font = .coolveticaRegular(ofSize: 15)
        priceTitleLabel.textColor = UIColor(white: 1.0, alpha: 0.5)

        priceLabel.font = .coolveticaRegular(ofSize: 30)

        numberOfPeopleView.backgroundColor = .clear
        numberOfPeopleBackgroundBlur.layer.cornerRadius = 20
        numberOfPeopleBackgroundBlur.clipsToBounds = true

        numberOfPeopleTitleLabel.font = .coolveticaRegular(ofSize: 15)
        numberOfPeopleTitleLabel.textColor = UIColor(white: 1.0, alpha: 0.5)

        numberOfPeopleLabel.font = .coolveticaRegular(ofSize: 30)

        packIncludesLabel.font = .coolveticaRegular(ofSize: 15)
        packIncludesLabel.textColor = UIColor(white: 1.0, alpha: 0.5)

        packDescriptionLabel.font = .coolveticaRegular(ofSize: 30)
        packDescriptionLabel.adjustsFontSizeToFitWidth = true
        packDescriptionLabel.minimumScaleFactor = 0.5
    }

}

extension DjDescriptionViewController {

    private func loadAllData() {
        viewModel.getDjDescription(for: id) { isLoaded in
            if isLoaded {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }

}

extension DjDescriptionViewController {

    private func updateUI() {
        descriptionTitle.text = viewModel.djDescriptionModel?.title.uppercased()
        priceLabel.text = viewModel.djDescriptionModel?.priceWithCurrency
        pictureView.image = viewModel.djDescriptionModel?.image
        numberOfPeopleLabel.text = viewModel.djDescriptionModel?.numberOfPeople
        packDescriptionLabel.text =
        viewModel.djDescriptionModel?.packDescription.replacingOccurrences(of: "\\n", with: "\n")
        setBackground()
    }

    func setBackground() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = viewModel.djDescriptionModel?.backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
    }

}
