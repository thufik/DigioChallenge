import UIKit

enum DetailsFactory {
    static func make(
        navigationController: UINavigationController,
        model: Codable
    ) -> UIViewController {
        let router = DetailsRouter(navigationController: navigationController)
        let presenter = DetailsPresenter(router: router)
        let interactor = DetailsInteractor(presenter: presenter)
        let viewController = DetailsViewController(
            interactor: interactor,
            model: model)

        presenter.view = viewController
        
        return viewController
    }
}
