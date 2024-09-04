import Foundation

extension String {
    
    func infoVariable() -> URLComponents {
        let bundle = Bundle.main
        guard
            let urlString = bundle.infoDictionary?[self] as? String,
            let url: URLComponents = URLComponents(string: urlString)
        else {
            fatalError("not possible to build URLComponent object in EnvironmentURLHandler class")
        }
        return url
    }
}
