import UIKit

protocol ___VARIABLE_moduleName___ViewProtocol: AnyObject {
    func setupNavigation()
    func setupView()
    func setupConstraints()
}

class ___VARIABLE_moduleName___ViewController: UIViewController {
    
    private let interactor: ___VARIABLE_moduleName___InteractorProtocol
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(interactor: ___VARIABLE_moduleName___InteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ___VARIABLE_moduleName___ViewController: ___VARIABLE_moduleName___ViewProtocol {
    func setupNavigation() {
        
    }
    
    func setupView() {
        
    }
    
    func setupConstraints() {
        
    }
}
