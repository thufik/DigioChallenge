import UIKit

final class HomeErrorView: UIView {
    
    private lazy var errorImageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: "retryImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()

    private lazy var errorButton: UIButton = {
        let button = UIButton()
        //button.addTarget(self, action: #selector(reload), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tentar novamente", for: .normal)
        button.setTitleColor(.grayColor, for: .normal)
        button.backgroundColor = .navyBlueColor
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.navyBlueColor.cgColor
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()

    private lazy var errorStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                errorImageView,
                errorButton
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    init() {
        super.init(frame: .zero)
        configView()
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configView() {
        backgroundColor = .white
    }

    private func setupViewHierarchy() {
        addSubview(errorStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            errorStackView.topAnchor.constraint(equalTo: topAnchor),
            errorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
