import Foundation

protocol ___VARIABLE_moduleName___PresenterProtocol: AnyObject {
    var view: ___VARIABLE_moduleName___ViewProtocol? { get set }
}

final class ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___PresenterProtocol {
    weak var view: ___VARIABLE_moduleName___ViewProtocol?
    
    private let router: ___VARIABLE_moduleName___RouterProtocol
    
    init(router: ___VARIABLE_moduleName___RouterProtocol) {
        self.router = router
    }
}
