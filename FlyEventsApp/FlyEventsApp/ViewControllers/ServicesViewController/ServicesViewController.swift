//
//  ServicesViewController.swift
//  FlyEventsApp
//
//  Created by David Farcas on 26.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ServicesViewController: UIViewController {

    @IBOutlet private weak var servicesTableView: UITableView!
    @IBOutlet private weak var djSectionButton: UIButton!
    @IBOutlet private weak var barSectionButton: UIButton!
    @IBOutlet private weak var fotoSectionButton: UIButton!
    @IBOutlet private weak var decorSectionButton: UIButton!


    private let viewModel = ServicesViewModel()
    var event: Event = Event.majorat

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadAllData()
    }

}

extension ServicesViewController {

   private func setupUI() {
        djSectionButton.isEnabled = false
        barSectionButton.isEnabled = false
        fotoSectionButton.isEnabled = false
        decorSectionButton.isEnabled = false
    }

    private func enableButtons() {
        djSectionButton.isEnabled = true
        barSectionButton.isEnabled = true
        fotoSectionButton.isEnabled = true
        decorSectionButton.isEnabled = true
    }

}

extension ServicesViewController {


       private func loadAllData() {
            viewModel.getServices(from: event) { isLoaded in
                if isLoaded {
                    DispatchQueue.main.async {
                        self.servicesTableView.reloadData()
                        self.enableButtons()
                    }
                }
            }
        }

}

extension ServicesViewController {

    @IBAction private func didTapDJ(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        servicesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    @IBAction private func didTapBar(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 1)
        servicesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    @IBAction private func didTapFoto(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 2)
        servicesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    @IBAction private func didTapDecor(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 3)
        servicesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

}

extension ServicesViewController: UITableViewDelegate, UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.servicesSections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.servicesSections[section][0].service
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.servicesSections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardCell
        let option = viewModel.servicesSections[indexPath.section][indexPath.row]
        cell?.setupCell(with: option, at: indexPath)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            goToDjDescritpionViewController()
        case 1:
            goToBarDescriptionViewController()
        case 2:
            goToFotoDescritpionViewController()
        case 3:
            goToDecorDescritpionViewController()
        default:
            return
        }


    }

   private func goToDjDescritpionViewController() {
        let viewController = DjDescriptionViewController.instantiate()
        present(viewController, animated: true)

    }

    private func goToBarDescriptionViewController() {
        let viewController = BarDescriptionViewController.instantiate()
        present(viewController, animated: true)

    }

    private func goToFotoDescritpionViewController() {
        let viewController = FotoDescriptionViewController.instantiate()
        present(viewController, animated: true)
    }

    private func goToDecorDescritpionViewController() {
        let viewController = DecorDescriptionViewController.instantiate()
        present(viewController, animated: true)
    }

}
