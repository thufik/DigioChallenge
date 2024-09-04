import Foundation

public extension URLComponents {
    var urlUnwrapped: URL {
        guard let url = self.url else {
            fatalError("Error getting URL from URLComponent Function: \(#function)  -- code line: \(#line)")
        }
        
        return url
    }
}
