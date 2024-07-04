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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!


    private let viewModel = ServicesViewModel()
    var event: Event = Event.majorat

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadAllData()
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension ServicesViewController {

    private func setupUI() {
        setBackground()
        setBackButton()
        setNavigationBar()

        djSectionButton.titleLabel?.font = .coolveticaFont(ofSize: 25, weight: .light)
        djSectionButton.setTitleColor(.lightGray, for: .normal)

        barSectionButton.titleLabel?.font = .coolveticaFont(ofSize: 25, weight: .light)
        barSectionButton.setTitleColor(.lightGray, for: .normal)

        fotoSectionButton.titleLabel?.font = .coolveticaFont(ofSize: 25, weight: .light)
        fotoSectionButton.setTitleColor(.lightGray, for: .normal)

        decorSectionButton.titleLabel?.font = .coolveticaFont(ofSize: 25, weight: .light)
        decorSectionButton.setTitleColor(.lightGray, for: .normal)

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

    private func setBackButton() {
        let backButtonImage = UIImage(named: "CustomBackNavIcon")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(didTapBack)
        )
        navigationItem.leftBarButtonItem = backButton
    }

    private func setNavigationBar() {
        if event == .majorat {
            self.navigationItem.title = "18th Birthday"
        } else {
            self.navigationItem.title = event.rawValue.capitalized
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.coolveticaFont(ofSize: 30, weight: .regular),
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
}

extension ServicesViewController {

    func setBackground() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "mainBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(backgroundImageView)

        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImageView.bounds
        blurredEffectView.alpha = 0.7
        view.addSubview(blurredEffectView)
        self.view.sendSubviewToBack(blurredEffectView)
        self.view.sendSubviewToBack(backgroundImageView)
    }

}

extension ServicesViewController {


       private func loadAllData() {
           self.activityIndicator.startAnimating()
            viewModel.getServices(from: event) { isLoaded in
                if isLoaded {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
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

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont.coolveticaFont(ofSize: 30, weight: .regular)
        header?.textLabel?.textColor = .white

        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = header?.bounds ?? CGRect()
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.9

        header?.addSubview(blurEffectView)
        header?.sendSubviewToBack(blurEffectView)

        header?.backgroundView = blurEffectView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
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
            goToDjDescritpionViewController(with: indexPath)
        case 1:
            let barDescriptionViewController = BarDescriptionViewController.instantiate()
            barDescriptionViewController.id = viewModel.servicesSections[indexPath.section][indexPath.row].id
            goToBarDescriptionViewController(with: indexPath)
        case 2:
            let fotoDescriptionViewController = FotoDescriptionViewController.instantiate()
            fotoDescriptionViewController.id = viewModel.servicesSections[indexPath.section][indexPath.row].id
            goToFotoDescritpionViewController(with: indexPath)
        case 3:
            let decorDescriptionViewController = DecorDescriptionViewController.instantiate()
            decorDescriptionViewController.id = viewModel.servicesSections[indexPath.section][indexPath.row].id
            goToDecorDescritpionViewController(with: indexPath)
        default:
            return
        }


    }

    private func goToDjDescritpionViewController(with indexPath: IndexPath) {
        let viewController = DjDescriptionViewController.instantiate()
        viewController.id = viewModel.servicesSections[indexPath.section][indexPath.row].id
        present(viewController, animated: true)


    }

    private func goToBarDescriptionViewController(with indexPath: IndexPath) {
        let viewController = BarDescriptionViewController.instantiate()
        viewController.id = viewModel.servicesSections[indexPath.section][indexPath.row].id
        present(viewController, animated: true)

    }

    private func goToFotoDescritpionViewController(with indexPath: IndexPath) {
        let viewController = FotoDescriptionViewController.instantiate()
        viewController.id = viewModel.servicesSections[indexPath.section][indexPath.row].id
        present(viewController, animated: true)
    }

    private func goToDecorDescritpionViewController(with indexPath: IndexPath) {
        let viewController = DecorDescriptionViewController.instantiate()
        viewController.id = viewModel.servicesSections[indexPath.section][indexPath.row].id
        present(viewController, animated: true)
    }

}
