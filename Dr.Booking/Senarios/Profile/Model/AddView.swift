// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dectorView = try? newJSONDecoder().decode(DectorView.self, from: jsonData)

import Foundation

// MARK: - DectorView
struct AddView: Codable {
    let status: Int
    let dates: String?
    let doctor: CarV
}

// MARK: - Doctor
struct CarV: Codable {
    let favorite: Int
    let id, name, address: String
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
