import Foundation
import RAMRequestManager

enum ErrorMessages: String, Error {
    case invalidServerResponse = "Invalid response from server"
    case invalidData = "The data received from the server was not valid"
}

enum ApiKeys {
    static let baseURL: String = "7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com"
}

enum Endpoints: String {
    case products = "/sandbox/procuts"
}

