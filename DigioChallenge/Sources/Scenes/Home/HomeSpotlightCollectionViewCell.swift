import UIKit

final class HomeSpotlightCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "cell"
    
    private var currentImageURL: URL?
    private var spotlight: SpotLight?

    private weak var delegate: HomeViewDelegate?

    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
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
            backView.heightAnchor.constraint(equalToConstant: 200),

            img.topAnchor.constraint(equalTo: backView.topAnchor),
            img.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            img.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            img.leadingAnchor.constraint(equalTo: backView.leadingAnchor)
        ])
    }
    
    func setupCell(spotlight: SpotLight, delegate: HomeViewDelegate) {
        self.spotlight = spotlight
        self.delegate = delegate
        self.currentImageURL = spotlight.bannerURL

        ImageFetcher.shared.fetch(url: spotlight.bannerURL) { result in
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
        delegate?.selectCell(model: spotlight)
    }
}
