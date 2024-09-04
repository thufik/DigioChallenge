import Foundation

protocol ___VARIABLE_moduleName___InteractorProtocol {
    func viewDidLoad()
}

final class ___VARIABLE_moduleName___Interactor: ___VARIABLE_moduleName___InteractorProtocol {
    private let worker: ___VARIABLE_moduleName___WorkerProtocol
    
    private let presenter: ___VARIABLE_moduleName___PresenterProtocol
    
    init(worker: ___VARIABLE_moduleName___WorkerProtocol,
         presenter: ___VARIABLE_moduleName___PresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        
    }
}
