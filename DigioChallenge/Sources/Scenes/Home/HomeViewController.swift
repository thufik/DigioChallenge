import Lottie
import UIKit

protocol HomeViewProtocol: AnyObject {
    func reloadCollectionData(with snapshot: NSDiffableDataSourceSnapshot<Int, SpotLight>)
    func reloadProductCollectionData(with snapshot: NSDiffableDataSourceSnapshot<Int, Product>)
    func setupHome(_ home: Home)
    func setupNavigation()
    func setupView()
    func setupConstraints()
    func setupErrorView()
    func startLoading()
    func stopLoading()
}

protocol HomeViewDelegate: AnyObject {
    func selectCell(model: Codable)
}

class HomeViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var spotlightDatasource: UICollectionViewDiffableDataSource<Int, SpotLight> = {
        let datasource = UICollectionViewDiffableDataSource<Int, SpotLight>(
            collectionView: spotlightCollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in

                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeSpotlightCollectionViewCell.cellIdentifier,
                    for: indexPath) as? HomeSpotlightCollectionViewCell
                else { preconditionFailure() }

                let spotlight = self.interactor.getSpotlight(at: indexPath.row)

                cell.setupCell(spotlight: spotlight, delegate: self)
                return cell
            })

        return datasource
    }()

    private lazy var productsDatasource: UICollectionViewDiffableDataSource<Int, Product> = {
        let datasource = UICollectionViewDiffableDataSource<Int, Product>(
            collectionView: productsCollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in

                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeProductCollectionViewCell.cellIdentifier,
                    for: indexPath) as? HomeProductCollectionViewCell
                else { preconditionFailure() }

                let product = self.interactor.getProduct(at: indexPath.row)

                cell.setupCell(product: product, delegate: self)
                return cell
            })

        return datasource
    }()

    private lazy var spotlightCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(
            HomeSpotlightCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeSpotlightCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.tag = 0
        return collectionView
    }()

    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: "headerIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return imageView
    }()

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Olá, Maria"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()

    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerImageView,
            headerLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private lazy var cashTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8

        return stackView
    }()

    private lazy var digioStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cashTitleLabel,
            digioCashImageView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(tapCashView)
            )
        )

        return stackView
    }()

    private lazy var digioCashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()

    private lazy var productsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(
            HomeProductCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeProductCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.tag = 1
        return collectionView
    }()

    private lazy var productsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                productsLabel,
                productsCollectionView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()

    private let interactor: HomeInteractorProtocol

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.backgroundColor = .white
    }

    @objc
    private func reload() {
        interactor.viewDidLoad()
    }

    @objc
    private func tapCashView() {
        interactor.tapCash()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView.tag == 0 {
            let width = collectionView.frame.width * 0.95
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: 130, height: 130)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeViewController: HomeViewProtocol {
    func setupNavigation() {
        view.backgroundColor = .white
    }

    func setupView() {
        view.addSubview(scrollView)

        scrollView.addSubview(contentStackView)

        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(spotlightCollectionView)
        contentStackView.addArrangedSubview(digioStackView)
        contentStackView.addArrangedSubview(productsStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            spotlightCollectionView.heightAnchor.constraint(equalToConstant: 200),

            productsCollectionView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }

    func reloadCollectionData(with snapshot: NSDiffableDataSourceSnapshot<Int, SpotLight>) {
        spotlightDatasource.apply(snapshot, animatingDifferences: true)
    }

    func reloadProductCollectionData(with snapshot: NSDiffableDataSourceSnapshot<Int, Product>) {
        productsDatasource.apply(snapshot, animatingDifferences: true)
    }

    func setupHome(_ home: Home) {
        let fullText = home.cash.title

        let attributedString = NSMutableAttributedString(string: fullText)

        let digioAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.navyBlueColor
        ]
        if let digioRange = (fullText as NSString).range(of: "digio") as NSRange? {
            attributedString.addAttributes(digioAttributes, range: digioRange)
        }

        let cashAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.grayColor
        ]
        if let cashRange = (fullText as NSString).range(of: "Cash") as NSRange? {
            attributedString.addAttributes(cashAttributes, range: cashRange)
        }

        cashTitleLabel.attributedText = attributedString

        productsLabel.text = "Produtos"

        ImageFetcher.shared.fetch(url: home.cash.bannerURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.digioCashImageView.image = image
                }
            case .failure:
                break
            }
        }
    }

    func setupErrorView() {
        let homeErrorView = HomeErrorView()

        view.addSubview(homeErrorView)

        NSLayoutConstraint.activate([
            homeErrorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            homeErrorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            homeErrorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    func startLoading() {
        view.addSubview(animationView)

        animationView.play()
    }

    func stopLoading() {
        animationView.removeFromSuperview()

        animationView.stop()
    }
}

extension HomeViewController: HomeViewDelegate {
    func selectCell(model: Codable) {
        interactor.selectCell(model: model)
    }
}
