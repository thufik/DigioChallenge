import UIKit

enum HomeFactory {
    static func make(navigationController: UINavigationController) -> UIViewController {
        let worker = HomeWorker()
        let router = HomeRouter(navigationController: navigationController)
        let presenter = HomePresenter(router: router)
        let interactor = HomeInteractor(worker: worker, presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)
        
        presenter.view = viewController
        
        return viewController
    }
}
