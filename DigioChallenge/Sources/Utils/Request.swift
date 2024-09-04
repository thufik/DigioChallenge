import Foundation

public enum Request {
    case products
    case filter(String, String)
    
    public var url: URL {
        var defaultBaseUrl = InfoPlist.baseURL.rawValue.infoVariable()
        
        defaultBaseUrl.path = "/\(value)"
        //defaultBaseUrl.queryItems = queryItems
        return defaultBaseUrl.urlUnwrapped
    }
    
    public var queryItems: [URLQueryItem] {
        switch self {
        case .products:
            return [
                URLQueryItem(name: "page", value: ""),
            ]
        case .filter(let name, let status):
            return [
                URLQueryItem(name: "name", value: "\(name)"),
                URLQueryItem(name: "status", value: "\(status.lowercased())"),
            ]
        }
    }
    
    
    public var value: String {
        switch self {
        case .products, .filter:
            return "sandbox/products"
        }
    }
}
