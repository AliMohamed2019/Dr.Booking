// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let login = try? newJSONDecoder().decode(Login.self, from: jsonData)

import Foundation

// MARK: - Login
struct Login: Codable {
    let status: Int
    let userData: UserData

    enum CodingKeys: String, CodingKey {
        case status
        case userData = "user_data"
    }
}

// MARK: - UserData
struct UserData: Codable {
    let id, name, mail, password , phone: String
    let photo, address, gender: String?
    let jobType, cityID, verified, status: String
    let created, date, deleted: String
    let createdBy, lastUpdatedBy: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, mail, password, phone, photo, address, gender
        case jobType = "job_type"
        case cityID = "city_id"
        case verified, status, created, date, deleted
        case createdBy = "created_by"
        case lastUpdatedBy = "last_updated_by"
    }
}

