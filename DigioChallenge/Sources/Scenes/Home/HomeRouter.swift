import Foundation
import UIKit

protocol HomeRouterProtocol {
    func pushDetailsScreen(model: Codable)
}

final class HomeRouter: HomeRouterProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func pushDetailsScreen(model: Codable) {
        let viewController = DetailsFactory.make(
            navigationController: navigationController,
            model: model)

        self.navigationController.pushViewController(
            viewController,
            animated: true
        )
    }
}
