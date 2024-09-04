import UIKit

enum ___VARIABLE_moduleName___Factory {
    static func make(navigationController: UINavigationController) -> UIViewController {
        let worker = ___VARIABLE_moduleName___Worker()
        let router = ___VARIABLE_moduleName___Router(navigationController: navigationController)
        let presenter = ___VARIABLE_moduleName___Presenter(router: router)
        let interactor = ___VARIABLE_moduleName___Interactor(worker: worker, presenter: presenter)
        let viewController = ___VARIABLE_moduleName___ViewController(interactor: interactor)
        
        presenter.view = viewController
        
        return viewController
    }
}
