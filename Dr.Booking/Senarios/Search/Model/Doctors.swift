// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let doctors = try? newJSONDecoder().decode(Doctors.self, from: jsonData)

import Foundation

// MARK: - Doctors
struct Doctors: Codable {
    let status: Int
    let doctors: [SearchDoctor]
}

// MARK: - Doctor
struct SearchDoctor: Codable {
    let favorite: Int
    let id, name: String
    let address: String
    let image: String
    let price, jobTitle, doctorDescription, longitude: String?
    let latitude: String?
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case favorite, id, name, address, image, price
        case jobTitle = "job_title"
        case doctorDescription = "description"
        case longitude, latitude, rating
    }
}


