import Foundation
import UIKit

protocol DetailsRouterProtocol {}

final class DetailsRouter: DetailsRouterProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
