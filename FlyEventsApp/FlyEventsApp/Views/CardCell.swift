//
//  CardCell.swift
//  FlyEventsApp
//
//  Created by David Farcas on 08.05.2024.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    func setupCell(with option: ServiceOptionModel, at indexPath: IndexPath) {
        titleLabel.text = option.title
        titleLabel.font = .coolveticaRegular(ofSize: 18)
        priceLabel.text = option.priceWithCurrency
        priceLabel.font = .coolveticaRegular(ofSize: 18)
        pictureView.image = option.image

        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOpacity = 0.8 // Try increasing opacity
        cardView.layer.shadowOffset = CGSize(width: 6.0, height: 6.0) // Try increasing offset
        cardView.layer.shadowRadius = 6.0 // Try increasing radius
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
    }

}
