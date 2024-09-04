import XCTest
import SnapshotTesting
import RAMRequestManager

@testable import DigioChallenge

class MyProjectTests: XCTestCase {
    func testErrorView() {
        let view = HomeErrorView()

        view.frame = CGRect(x: 0, y: 0, width: 400, height: 900)

        assertSnapshot(of: view, as: .image)
    }
}
