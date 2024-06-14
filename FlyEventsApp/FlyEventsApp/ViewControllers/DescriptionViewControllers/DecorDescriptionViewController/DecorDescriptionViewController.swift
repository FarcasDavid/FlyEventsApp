//
//  DecorDescriptionViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 02.06.2024.
//

import Foundation
import UIKit

class DecorDescriptionViewController: UIViewController {

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

    private var viewModel = DecorDescriptionViewModel()
    var id: String = ""


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
      //  leftTopView.layer.cornerRadius = 10
      //  leftTopImageView.layer.cornerRadius = 10

        rightTopView.backgroundColor = .white
     //   rightTopView.layer.cornerRadius = 10
     //   rightTopImageView.layer.cornerRadius = 10

        middleView.backgroundColor = .white
   //     middleView.layer.cornerRadius = 10
   //     middleImageView.layer.cornerRadius = 10

        leftBottomView.backgroundColor = .white
    //    leftBottomView.layer.cornerRadius = 10
    //    leftBottomImageView.layer.cornerRadius = 10

        rightBottomView.backgroundColor = .white
   //     rightBottomView.layer.cornerRadius = 10
     //   rightBottomImageView.layer.cornerRadius = 10


    }
}

extension DecorDescriptionViewController {

    private func loadAllData() {
        viewModel.getDecorDescription(for: id) { isLoaded in
            if isLoaded {
                DispatchQueue.main.async {
                    self.updateUI()
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
