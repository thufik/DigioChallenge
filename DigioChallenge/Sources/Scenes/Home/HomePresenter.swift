import Foundation
import UIKit

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    
    func reload(with home: Home)
    func initialSetupView()
    func startLoading()
    func stopLoading()
    func setupErrorView()
    func select(model: Codable)
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    
    private let router: HomeRouterProtocol
    
    init(router: HomeRouterProtocol) {
        self.router = router
    }
    
    func reload(with home: Home) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SpotLight>()
        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(home.spotlight)

        var productSnapshot = NSDiffableDataSourceSnapshot<Int, Product>()
        productSnapshot.deleteAllItems()
        productSnapshot.appendSections([0])
        productSnapshot.appendItems(home.products)

        DispatchQueue.main.async {
            self.view?.reloadCollectionData(with: snapshot)
            self.view?.reloadProductCollectionData(with: productSnapshot)
            self.view?.setupHome(home)
        }
    }
    
    func initialSetupView() {
        DispatchQueue.main.async {
            self.view?.setupNavigation()
            self.view?.setupView()
            self.view?.setupConstraints()
        }
    }

    func setupErrorView() {
        DispatchQueue.main.async {
            self.view?.setupErrorView()
        }
    }

    func startLoading() {
        view?.startLoading()
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.view?.stopLoading()
        }
    }

    func select(model: Codable) {
        router.pushDetailsScreen(model: model)
    }
}
