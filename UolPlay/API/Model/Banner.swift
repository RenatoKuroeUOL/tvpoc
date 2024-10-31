// Make Banner conform to Identifiable, Codable, and Equatable
import Foundation

struct Banner: Identifiable, Codable, Equatable {
    let id: Int
    let backdropPath: String?  // Ensure this field corresponds to the API's "image_path" key
    let title: String?  // Title of the banner
    let overview: String?  // Description for the banner
    
    // Create a computed property for the full image URL
    var imageURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }

    // Map the API response's "image_path" key to the Swift "imagePath" property
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"  // Ensure the key matches the API's field name
        case title = "title"
        case overview = "overview"
    }
}

struct BannerResponse: Codable {
    let results: [Banner]
}

