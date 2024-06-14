//
//  CardCell.swift
//  FlyEventsApp
//
//  Created by David Farcas on 08.05.2024.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
    }

    // TODO: Vezi cum rotunjesti containerView fara sa pierzi umbra

    private func setupView() {
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.8 // Shadow opacity
        containerView.layer.shadowOffset = CGSize(width: 6.0, height: 6.0) // Shadow offset
        containerView.layer.shadowRadius = 6.0 // Shadow radius
        containerView.layer.masksToBounds = false

        cardView.layer.cornerRadius = 20.0
        cardView.layer.masksToBounds = true // Ensure the card view clips its bounds
    }

    func setupCell(with option: ServiceOptionModel, at indexPath: IndexPath) {
        titleLabel.text = option.title
        titleLabel.font = .coolveticaRegular(ofSize: 18)
        priceLabel.text = option.priceWithCurrency
        priceLabel.font = .coolveticaRegular(ofSize: 18)
        pictureView.image = option.image
    }
}
