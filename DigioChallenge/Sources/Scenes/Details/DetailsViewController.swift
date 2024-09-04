import UIKit

protocol DetailsViewProtocol: AnyObject {
    func setupNavigation()
    func setupView()
    func setupConstraints()
}

class DetailsViewController: UIViewController {

    private lazy var img: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            mainDescription
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 16
        stackView.backgroundColor = .navyBlueColor
        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var mainDescription: UILabel = {
        let titulo = UILabel()
        titulo.numberOfLines = 0
        titulo.textColor = .white
        titulo.textAlignment = .left
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()

    private let interactor: DetailsInteractorProtocol
    private let model: Codable

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(interactor: DetailsInteractorProtocol, model: Codable) {
        self.interactor = interactor
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let spotlight = model as? SpotLight {
            renderSpotlight(spotlight)
        } else if let cash = model as? Cash {
            renderCash(cash)
        } else if let product = model as? Product {
            renderProduct(product)
        }

        setupNavigation()
        setupView()
        setupConstraints()
    }

    private func renderSpotlight(_ spotlight: SpotLight) {
        title = spotlight.name

        mainDescription.text = spotlight.description

        loadImage(spotlight.bannerURL)
    }

    private func renderCash(_ cash: Cash) {
        title = cash.title

        mainDescription.text = cash.description

        img.contentMode = .scaleAspectFit

        loadImage(cash.bannerURL)
    }

    private func renderProduct(_ product: Product) {
        title = product.name

        mainDescription.text = product.description

        img.contentMode = .scaleAspectFit

        loadImage(product.imageURL)

        NSLayoutConstraint.activate([
            img.heightAnchor.constraint(equalToConstant: 50),
            img.widthAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func loadImage(_ url: URL) {
        let imageFetcher = ImageFetcher()
        imageFetcher.fetch(url: url, { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.img.image = image
                }
            case .failure:
                break
            }
        })
    }

    @objc
    private func back() {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailsViewController: DetailsViewProtocol {
    func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem =  UIBarButtonItem(
            image: UIImage(named: "back")?
                .resizeImage(targetSize: CGSize(width: 25, height: 25)), style: .done, target: self, action: #selector(back))
        view.backgroundColor = .white
    }
    
    func setupView() {
        view.addSubview(img)
        view.addSubview(detailsStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            img.heightAnchor.constraint(equalToConstant: 150),
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            img.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            detailsStackView.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 32),
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
