//
//  DjAndBarDescriptionViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 02.06.2024.
//

import Foundation
import UIKit

class DjDescriptionViewController: UIViewController {

    @IBOutlet private weak var backgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var titleBackground: UIVisualEffectView!
    @IBOutlet private weak var descriptionTitle: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var packPriceView: UIView!
    @IBOutlet private weak var numberOfPeopleView: UIView!
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var numberOfPeopleLabel: UILabel!
    @IBOutlet private weak var priceBackgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var numberOfPeopleBackgroundBlur: UIVisualEffectView!
    @IBOutlet private weak var packDescriptionLabel: UILabel!
    @IBOutlet private weak var packIncludesLabel: UILabel!
    @IBOutlet private weak var descriptionBackgroundBlur: UIVisualEffectView!

    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }

}

extension DjDescriptionViewController {

    private func setupUI() {
        backgroundBlur.layer.cornerRadius = 20
        titleBackground.layer.cornerRadius = 20
        packPriceView.layer.cornerRadius = 20
        numberOfPeopleView.layer.cornerRadius = 20
        pictureView.layer.cornerRadius = 20
        priceBackgroundBlur.layer.cornerRadius = 20
        numberOfPeopleBackgroundBlur.layer.cornerRadius = 20
        descriptionBackgroundBlur.layer.cornerRadius = 20
        descriptionTitle.font = .coolveticaRegular(ofSize: 30)
        priceLabel.font = .coolveticaRegular(ofSize: 15)
        priceLabel.textColor = UIColor(white: 1.0, alpha: 0.5)
        numberOfPeopleLabel.font = .coolveticaRegular(ofSize: 15)
        numberOfPeopleLabel.textColor = UIColor(white: 1.0, alpha: 0.5)
        packIncludesLabel.font = .coolveticaRegular(ofSize: 15)
        packIncludesLabel.textColor = UIColor(white: 1.0, alpha: 0.5)
        packDescriptionLabel.font = .coolveticaRegular(ofSize: 30)
    }

}
