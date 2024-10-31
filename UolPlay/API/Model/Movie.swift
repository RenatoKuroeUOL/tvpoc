import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String? // Map to the API's poster_path field
    let overview: String
    
    // CodingKeys maps your Swift property to the JSON keys
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path" // Map "posterPath" to the "poster_path" from the API
        case overview
    }

    // Construct the full URL for the poster image
    var posterURL: URL? {
        if let posterPath = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        } else {
            return nil // Handle case when posterPath is nil
        }
    }
}


