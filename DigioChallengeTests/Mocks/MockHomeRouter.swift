import Foundation
import RAMRequestManager
@testable import DigioChallenge

final class MockHomeRouter: HomeRouterProtocol {
    var pushDetailsScreenCalled = false
    
    func pushDetailsScreen(model: Codable) {
        pushDetailsScreenCalled = true
    }
}
