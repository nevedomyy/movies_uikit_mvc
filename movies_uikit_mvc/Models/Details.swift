// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let details = try? JSONDecoder().decode(Details.self, from: jsonData)

import Foundation

// MARK: - Details
struct Details: Codable {
    let backdropPath, overview, title: String
    let budget: Int
    let voteAverage: Double


    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget, overview, title
        case voteAverage = "vote_average"
    }
}
