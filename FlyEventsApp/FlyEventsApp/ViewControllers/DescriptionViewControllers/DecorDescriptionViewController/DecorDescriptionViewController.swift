//
//  DecorDescriptionViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 02.06.2024.
//

import Foundation
import UIKit

class DecorDescriptionViewController: UIViewController {

    @IBOutlet private weak var loadingIndicatorView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var upperStackView: UIStackView!
    @IBOutlet private weak var middleStackView: UIStackView!
    @IBOutlet private weak var lowerStackView: UIStackView!
    @IBOutlet private weak var leftTopView: UIView!
    @IBOutlet private weak var leftTopImageView: UIImageView!
    @IBOutlet private weak var rightTopView: UIView!
    @IBOutlet private weak var rightTopImageView: UIImageView!
    @IBOutlet private weak var middleView: UIView!
    @IBOutlet private weak var middleImageView: UIImageView!
    @IBOutlet private weak var leftBottomView: UIView!
    @IBOutlet private weak var leftBottomImageView: UIImageView!
    @IBOutlet private weak var rightBottomView: UIView!
    @IBOutlet private weak var rightBottomImageView: UIImageView!
    @IBOutlet private weak var cartButton: UIButton!

    private var viewModel = DecorDescriptionViewModel()
    var id: String = ""
    var addToCart: ((String) -> Void)?


   override func viewDidLoad() {
        super.viewDidLoad()

       loadAllData()
       setupUI()
    }

}

extension DecorDescriptionViewController {

    private func setupUI() {

        self.view.backgroundColor = UIColor(
            red: 237 / 255.0,
            green: 229 / 255.0,
            blue: 227 / 255.0,
            alpha: 1.0
        )

        leftTopView.backgroundColor = .white
        rightTopView.backgroundColor = .white
        middleView.backgroundColor = .white
        leftBottomView.backgroundColor = .white
        rightBottomView.backgroundColor = .white

        cartButton.titleLabel?.font = .coolveticaFont(ofSize: 20, weight: .regular)
        cartButton.setTitleColor(.white, for: .normal)
        cartButton.backgroundColor = .darkGray
        cartButton.layer.cornerRadius = 10
    }
}

extension DecorDescriptionViewController {

    private func loadAllData() {
        loadingIndicatorView.isHidden = false
        activityIndicator.startAnimating()
        viewModel.getDecorDescription(for: id) { isLoaded in
            if isLoaded {
                DispatchQueue.main.async {
                    self.updateUI()
                    self.loadingIndicatorView.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

}

extension DecorDescriptionViewController {

    private func updateUI() {
        leftTopImageView.image = viewModel.decorDescriptionModel?.images[0]
        rightTopImageView.image = viewModel.decorDescriptionModel?.images[1]
        middleImageView.image = viewModel.decorDescriptionModel?.images[2]
        leftBottomImageView.image = viewModel.decorDescriptionModel?.images[3]
        rightBottomImageView.image = viewModel.decorDescriptionModel?.images[4]
    }

}

extension DecorDescriptionViewController {
    @IBAction private func didTapCartButton(_ sender: Any) {
        addToCart?(id)
        self.dismiss(animated: true)
    }
}
