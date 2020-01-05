// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let doctorInfo = try? newJSONDecoder().decode(DoctorInfo.self, from: jsonData)

import Foundation

// MARK: - DoctorInfo
struct CarInfo: Codable {
    let status: Int
    let dates: [ReserveDate]
    let doctor: Car
}

// MARK: - DateElement
struct ReserveDate: Codable {
    let id, idUser, reservationDate, fromTime: String
    let toTime, place, createdBy, created: String
    let lastUpdatedBy, updatedAt, deleted, status: String

    enum CodingKeys: String, CodingKey {
        case id
        case idUser = "id_user"
        case reservationDate = "reservation_date"
        case fromTime = "from_time"
        case toTime = "to_time"
        case place
        case createdBy = "created_by"
        case created
        case lastUpdatedBy = "last_updated_by"
        case updatedAt, deleted, status
    }
}

// MARK: - Doctor
struct Car: Codable {
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
