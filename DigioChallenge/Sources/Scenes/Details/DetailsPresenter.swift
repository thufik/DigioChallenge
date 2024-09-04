import Foundation

protocol DetailsPresenterProtocol: AnyObject {
    var view: DetailsViewProtocol? { get set }
}

final class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    
    private let router: DetailsRouterProtocol
    
    init(router: DetailsRouterProtocol) {
        self.router = router
    }
}
