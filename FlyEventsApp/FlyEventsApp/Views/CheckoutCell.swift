//
//  CheckoutCell.swift
//  FlyEventsApp
//
//  Created by David Farcas on 08.07.2024.
//

import UIKit

class CheckoutCell: UITableViewCell {

    @IBOutlet private weak var containerBlurView: UIVisualEffectView!
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var serviceLabel: UILabel!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var deleteItemButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupBackgrounds()
        setupView()
    }

    private func setupView() {

        cardView.layer.cornerRadius = 20.0
        cardView.layer.masksToBounds = true // Ensure the card view clips its bounds
        containerBlurView.layer.cornerRadius = 20
        containerBlurView.layer.masksToBounds = true
        pictureView.layer.cornerRadius = 20
        pictureView.layer.masksToBounds = true
        deleteItemButton.setImage(UIImage(named: "trashIcon"), for: .normal)
        deleteItemButton.imageView?.contentMode = .scaleAspectFit
    }

    private func setupBackgrounds() {
        // Set the backgroundView to clear
        let clearView = UIView()
        clearView.backgroundColor = .clear
        self.backgroundView = clearView

        // Set the contentView background to clear
        self.contentView.backgroundColor = .clear

        // Optionally, set the cell's background color to clear as well
        self.backgroundColor = .clear
    }

    func setupCell(with selectedService: ServiceOptionModel, at indexPath: IndexPath) {
        titleLabel.text = selectedService.title
        titleLabel.font = .coolveticaFont(ofSize: 20, weight: .bold)
        priceLabel.text = selectedService.priceWithCurrency
        priceLabel.font = .coolveticaFont(ofSize: 20, weight: .bold)
        serviceLabel.font = .coolveticaFont(ofSize: 16, weight: .light)
        serviceLabel.text = "Service: \(selectedService.service)"
        pictureView.image = selectedService.image
    }
}
