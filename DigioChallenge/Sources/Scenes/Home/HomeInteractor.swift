import Foundation

protocol HomeInteractorProtocol {
    func viewDidLoad()
    func loadHome()
    func getSpotlight(at index: Int) -> SpotLight
    func getProduct(at index: Int) -> Product
    func selectCell(model: Codable)
    func tapCash()

    var worker: HomeWorkerProtocol { get set }
    var presenter: HomePresenterProtocol { get set }
}

final class HomeInteractor: HomeInteractorProtocol  {
    
    var worker: HomeWorkerProtocol
    
    var presenter: HomePresenterProtocol

    private var home: Home?

    init(worker: HomeWorkerProtocol, presenter: HomePresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        loadHome()
    }
    
    func loadHome() {
        presenter.startLoading()

        worker.getHome { result in
            self.presenter.stopLoading()

            switch result {
            case .success(let home):
                self.home = home
                self.presenter.initialSetupView()
                self.presenter.reload(with: home)
            case .failure:
                self.presenter.setupErrorView()
            }
        }
    }
    
    func getSpotlight(at index: Int) -> SpotLight {
        home?.spotlight[index] ?? .init(name: "", bannerURL: .init(fileReferenceLiteralResourceName: ""), description: "")
    }

    func getProduct(at index: Int) -> Product {
        home?.products[index] ?? .init(name: "", imageURL: .init(fileReferenceLiteralResourceName: ""), description: "")
    }

    func selectCell(model: Codable) {
        presenter.select(model: model)
    }

    func tapCash() {
        guard let home else { return }
        presenter.select(model: home.cash)
    }
}
