// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let allFavoriteDoctor = try? newJSONDecoder().decode(AllFavoriteDoctor.self, from: jsonData)

import Foundation

// MARK: - AllFavoriteDoctor
struct AllFavoriteDoctor: Codable {
    let status: Int
    let doctors: [Doctor]
}

// MARK: - Doctor
struct Doctor: Codable {
    let favorite: Int
    let id, name, address: String
    let image: String
    let price, jobTitle, doctorDescription, longitude: String
    let latitude: String
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case favorite, id, name, address, image, price
        case jobTitle = "job_title"
        case doctorDescription = "description"
        case longitude, latitude, rating
    }
}
