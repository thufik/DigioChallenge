import Foundation

protocol DetailsInteractorProtocol {}

final class DetailsInteractor: DetailsInteractorProtocol {
    private let presenter: DetailsPresenterProtocol
    
    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
    }
}
