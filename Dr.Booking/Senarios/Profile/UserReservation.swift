// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userReservation = try? newJSONDecoder().decode(UserReservation.self, from: jsonData)

import Foundation

// MARK: - UserReservation
struct UserReservation: Codable {
    let status: Int
    let reservations: [Reservation]
}

// MARK: - Reservation
struct Reservation: Codable {
    let id, doctorID, doctor: String
    let image: String
    let price, jobTitle, longitude, latitude: String
    let rate: Double
    let date, timeFrom, timeTo, place: String?

    enum CodingKeys: String, CodingKey {
        case id
        case doctorID = "doctor_id"
        case doctor, image, price
        case jobTitle = "job_title"
        case longitude, latitude, rate, date, timeFrom, timeTo, place
    }
}

