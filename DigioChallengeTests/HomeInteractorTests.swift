import XCTest
@testable import DigioChallenge

class HomeInteractorTests: XCTestCase {
    
    func testViewDidLoadSuccess() {
        let mockWorker = MockHomeWorker(success: true)
        let mockPresenter = MockHomePresenter()
        let interactor = HomeInteractor(worker: mockWorker, presenter: mockPresenter)
        
        interactor.viewDidLoad()

        
        XCTAssertTrue(mockPresenter.initialSetupViewWasCalled)
        XCTAssertTrue(mockPresenter.reloadWasCalled)
    }

    func testViewDidLoadFailure() {
        let mockWorker = MockHomeWorker(success: false)
        let mockPresenter = MockHomePresenter()
        let interactor = HomeInteractor(worker: mockWorker, presenter: mockPresenter)
        
        interactor.viewDidLoad()

        XCTAssertTrue(mockPresenter.setupErrorViewWasCalled)
    }
}
