//
//  FotoDescriptionViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 02.06.2024.
//

import Foundation
import UIKit

class FotoDescriptionViewController: UIViewController {

    @IBOutlet private weak var fotoImageView: UIImageView!

    private let viewModel = FotoDescriptionViewModel()
    var id: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        loadAllData()
        // setupUI()
    }

}

extension FotoDescriptionViewController {

    private func loadAllData() {
        viewModel.getFotoDescription(for: id) { isLoaded in
            if isLoaded {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }

    private func updateUI() {
        fotoImageView.image = viewModel.fotoDescriptionModel?.image
    }

}
