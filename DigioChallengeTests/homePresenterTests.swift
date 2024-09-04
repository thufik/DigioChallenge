import XCTest
@testable import DigioChallenge

final class HomePresenterTests: XCTestCase {

    var reloadCollectionDataWasCalled = false
    var reloadProductCollectionDataWasCalled = false
    var setupHomeWasCalled = false
    var setupNavigationWasCalled = false
    var setupViewWasCalled = false
    var setupConstraintsWasCalled = false
    var setupErrorViewWasCalled = false
    var startLoadingWasCalled = false
    var stopLoadingWasCalled = false

    func testInitialSetupView() {
        let expectation = self.expectation(description: "Initial setup view")
        let mockRouter = MockHomeRouter()
        let presenter = HomePresenter(router: mockRouter)
        let interactor = HomeInteractor(worker: MockHomeWorker(), presenter: presenter)
        presenter.view = self

        interactor.viewDidLoad()

        DispatchQueue.main.async {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertTrue(setupNavigationWasCalled, "setupNavigation should be called")
        XCTAssertTrue(setupViewWasCalled, "setupView should be called")
        XCTAssertTrue(setupConstraintsWasCalled, "setupConstraints should be called")
        XCTAssertTrue(reloadCollectionDataWasCalled, "reloadCollectionData should be called")
        XCTAssertTrue(reloadProductCollectionDataWasCalled, "reloadProductCollectionData should be called")
        XCTAssertTrue(setupHomeWasCalled, "setupHome should be called")
    }
}

extension HomePresenterTests: HomeViewProtocol {
    func reloadCollectionData(with snapshot: NSDiffableDataSourceSnapshot<Int, SpotLight>) {
        reloadCollectionDataWasCalled = true
    }

    func reloadProductCollectionData(with snapshot: NSDiffableDataSourceSnapshot<Int, Product>) {
        reloadProductCollectionDataWasCalled = true
    }

    func setupHome(_ home: DigioChallenge.Home) {
        setupHomeWasCalled = true
    }

    func setupNavigation() {
        setupNavigationWasCalled = true
    }

    func setupView() {
        setupViewWasCalled = true
    }

    func setupConstraints() {
        setupConstraintsWasCalled = true
    }

    func setupErrorView() {
        setupErrorViewWasCalled = true
    }

    func startLoading() {
        startLoadingWasCalled = true
    }

    func stopLoading() {
        stopLoadingWasCalled = true
    }
}
