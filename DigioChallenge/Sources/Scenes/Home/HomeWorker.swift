import Foundation
import RAMRequestManager

protocol HomeWorkerProtocol {
    func getHome(completion: @escaping (Result<Home, ResultError>) -> ())
}

final class HomeWorker: HomeWorkerProtocol {
    private let service: Api
    
    init(service: Api = Api()) {
        self.service = service
    }
    
    func getHome(completion: @escaping (Result<Home, ResultError>) -> ()) {
        service.request(
            url: Request.products.url,
            method: .GET,
            with: nil,
            completion: completion
        )
    }
}
