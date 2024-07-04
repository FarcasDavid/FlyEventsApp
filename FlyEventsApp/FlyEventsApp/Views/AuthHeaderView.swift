import UIKit

class AuthHeaderView: UIView {

    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .coolveticaFont(ofSize: 26, weight: .bold)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        label.textAlignment = .center
        label.font = .coolveticaFont(ofSize: 18, weight: .regular)
        return label
    }()

    // MARK: - Lifecycle
    init(title: String, subTitle: String) {
        super.init(frame: .zero)

        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Update corner radius after frame has been set
        logoImageView.layer.cornerRadius = logoImageView.bounds.width / 2
    }

    private func setupUI() {

        logoImageView.image = UIImage(named: "logo")
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 90),
            self.logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),

            self.titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 19),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}
