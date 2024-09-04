import Foundation
import RAMRequestManager
@testable import DigioChallenge

final class MockHomeWorker: HomeWorkerProtocol {
    private var success: Bool

    init(success: Bool = true) {
        self.success = success
    }

    func getHome(completion: @escaping (Result<Home, ResultError>) -> ()) {
        if success {
            completion(
                .success(
                    .init(
                        spotlight: [
                            .init(name: "teste", bannerURL: URL(string: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png")!, description: "teste")
                        ],

                        products: [

                        ],

                        cash: .init(
                            title: "teste",
                            bannerURL: URL(string: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png")!,
                            description: "teste")
                    )
                )
            )
        } else {
            completion(.failure(.internalServerError))
        }
    }
}
