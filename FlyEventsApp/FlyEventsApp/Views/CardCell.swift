//
//  CardCell.swift
//  FlyEventsApp
//
//  Created by David Farcas on 08.05.2024.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet private weak var containerBlurView: UIVisualEffectView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupBackgrounds()
        setupView()
    }

    // TODO: Vezi cum rotunjesti containerView fara sa pierzi umbra

    private func setupView() {

        cardView.layer.cornerRadius = 20.0
        cardView.layer.masksToBounds = true // Ensure the card view clips its bounds
        containerBlurView.layer.cornerRadius = 20
        containerBlurView.layer.masksToBounds = true
        pictureView.layer.cornerRadius = 20
        pictureView.layer.masksToBounds = true
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

    func setupCell(with option: ServiceOptionModel, at indexPath: IndexPath) {
        titleLabel.text = option.title
        titleLabel.font = .coolveticaFont(ofSize: 20, weight: .regular)
        priceLabel.text = option.priceWithCurrency
        priceLabel.font = .coolveticaFont(ofSize: 20, weight: .regular)
        pictureView.image = option.image
    }
}
