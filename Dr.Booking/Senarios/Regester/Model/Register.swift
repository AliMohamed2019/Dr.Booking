// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let register = try? newJSONDecoder().decode(Register.self, from: jsonData)

import Foundation

// MARK: - Register
struct Register: Codable {
    let status: Int
    let idUser, message: String

    enum CodingKeys: String, CodingKey {
        case status
        case idUser = "id_user"
        case message
    }
}

