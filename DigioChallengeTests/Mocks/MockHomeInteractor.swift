import Foundation
import UIKit
@testable import DigioChallenge

final class MockHomeInteractor: HomeInteractorProtocol {
    var worker: HomeWorkerProtocol = MockHomeWorker()

    var presenter: HomePresenterProtocol = MockHomePresenter()

    func viewDidLoad() {

    }
    
    func loadHome() {

    }
    
    func getSpotlight(at index: Int) -> SpotLight {
        return .init(name: "", bannerURL: URL(string: "")!, description: "")
    }
    
    func getProduct(at index: Int) -> Product {
        return .init(name: "", imageURL: URL(string: "")!, description: "")
    }
    
    func selectCell(model: Codable) {

    }
    
    func tapCash() {

    }
}
