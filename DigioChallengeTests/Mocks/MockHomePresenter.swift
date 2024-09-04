import Foundation
import RAMRequestManager
@testable import DigioChallenge

class MockHomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    
    var startLoadingWasCalled = false
    var stopLoadingWasCalled = false
    var setupErrorViewWasCalled = false
    var selectWasCalled = false
    var reloadWasCalled = false
    var initialSetupViewWasCalled = false

    func startLoading() {
        startLoadingWasCalled = true
    }

    func stopLoading() {
        stopLoadingWasCalled = true
    }

    func setupErrorView() {
        setupErrorViewWasCalled = true
    }

    func select(model: Codable) {
        selectWasCalled = true
    }

    func reload(with home: Home) {
        reloadWasCalled = true
    }

    func initialSetupView() {
        initialSetupViewWasCalled = true
    }
}
