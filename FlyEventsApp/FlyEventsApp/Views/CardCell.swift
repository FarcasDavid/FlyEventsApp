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
        priceLabel.text = option.price
        pictureView.image = option.image
        // TODO: Verificarea asta se face inainte, la didTapEvent actions din choose event
//        pictureView.image = ServiceOptionModel.image


//        if let event = Event(rawValue: option.event) {
//            
//            switch event {
//            case Event.majorat:
//                pictureView.image = EventImages.majorat.images[indexPath.row]
//
//            case Event.baptising:
//                pictureView.image = EventImages.baptising.images[indexPath.row]            
//            case Event.wedding:
//                pictureView.image = EventImages.wedding.images[indexPath.row]
//
//            case Event.corporate:
//                // Add corporate images handling here if needed
//                break
//            }
//                }

        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOpacity = 0.8 // Try increasing opacity
        cardView.layer.shadowOffset = CGSize(width: 6.0, height: 6.0) // Try increasing offset
        cardView.layer.shadowRadius = 6.0 // Try increasing radius
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
    }

}
