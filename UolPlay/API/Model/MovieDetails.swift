import Foundation

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let releaseDate: String?
    let overview: String?
    let runtime: Int?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres
        case releaseDate = "release_date"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
