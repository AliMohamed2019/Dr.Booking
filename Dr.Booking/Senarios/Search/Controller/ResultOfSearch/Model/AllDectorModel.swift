// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let allDectorModel = try? newJSONDecoder().decode(AllDectorModel.self, from: jsonData)

import Foundation

// MARK: - AllDectorModel
struct AllDectorModel: Codable {
    let status: Int
    let doctors: [AllDoctor]
}

// MARK: - Doctor
struct AllDoctor: Codable {
    let favorite: Int
    let id, name,address: String
    let image: String
    let price, jobTitle, doctorDescription, longitude: String
    let latitude: String
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case favorite, id, name, address, image, price
        case jobTitle = "job_title"
        case doctorDescription = "description"
        case longitude, latitude, rating
    }
}

