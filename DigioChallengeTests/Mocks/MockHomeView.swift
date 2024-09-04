import Foundation
import UIKit
import RAMRequestManager
@testable import DigioChallenge

final class MockHomeView: HomeViewProtocol {
    var reloadCollectionDataWasCalled = false
    var reloadProductCollectionDataWasCalled = false
    var setupHomeWasCalled = false
    var setupNavigationWasCalled = false
    var setupViewWasCalled = false
    var setupConstraintsWasCalled = false
    var setupErrorViewWasCalled = false
    var startLoadingWasCalled = false
    var stopLoadingWasCalled = false

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
