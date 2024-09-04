import UIKit

class HomeProductCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "product"
    
    private var currentImageURL: URL?
    private var product: Product?

    private weak var delegate: HomeViewDelegate?

    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(selectCell)
            )
        )

        return view
    }()

    lazy var img: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setConstraints()
    }


    override func prepareForReuse() {
        super.prepareForReuse()

        if let currentImageURL {
            ImageFetcher.shared.cancel(url: currentImageURL)
        }

        img.image = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupHierarchy() {
        contentView.addSubview(backView)

        backView.addSubview(img)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            img.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            img.heightAnchor.constraint(equalToConstant: 50),
            img.widthAnchor.constraint(equalToConstant: 50),
        ])
    }

    func setupCell(product: Product, delegate: HomeViewDelegate) {
        self.currentImageURL = product.imageURL
        self.product = product
        self.delegate = delegate

        ImageFetcher.shared.fetch(url: product.imageURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.img.image = image
                }
            case .failure:
                break
            }
        }
    }

    @objc
    private func selectCell() {
        delegate?.selectCell(model: product)
    }
}
