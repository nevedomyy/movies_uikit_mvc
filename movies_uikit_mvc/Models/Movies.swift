// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movies = try? JSONDecoder().decode(Movies.self, from: jsonData)

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable {
    let id: Int
    let posterPath, overview, title: String

    enum CodingKeys: String, CodingKey {
        case id
        case overview, title
        case posterPath = "poster_path"
    }
}
