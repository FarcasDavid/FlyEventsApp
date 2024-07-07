//
//  FotoDescriptionViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 02.06.2024.
//

import Foundation
import UIKit

class FotoDescriptionViewController: UIViewController {

    @IBOutlet private weak var loadingIndicatorView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet private weak var fotoImageView: UIImageView!

    private let viewModel = FotoDescriptionViewModel()
    var id: String = ""
    var addToCart: ((String) -> Void)?


    override func viewDidLoad() {
        super.viewDidLoad()

        loadAllData()
    }

}

extension FotoDescriptionViewController {

    private func loadAllData() {
        loadingIndicatorView.isHidden = false
        activityIndicator.startAnimating()
        viewModel.getFotoDescription(for: id) { isLoaded in
            if isLoaded {
                DispatchQueue.main.async {
                    self.updateUI()
                    self.loadingIndicatorView.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    private func updateUI() {
        fotoImageView.image = viewModel.fotoDescriptionModel?.image
    }

}

extension FotoDescriptionViewController {

    @IBAction private func didTapCartButton(_ sender: Any) {
        addToCart?(id)
        self.dismiss(animated: true)
    }
}
