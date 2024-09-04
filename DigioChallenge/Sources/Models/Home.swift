import Foundation

struct Home: Codable {
    let spotlight: [SpotLight]
    let products: [Product]
    let cash: Cash
}

struct SpotLight: Codable, Hashable {
    let name: String
    let bannerURL: URL
    let `description`: String
}

struct Product: Codable, Hashable {
    let name: String
    let imageURL: URL
    let `description`: String
}

struct Cash: Codable {
    let title: String
    let bannerURL: URL
    let `description`: String
}
