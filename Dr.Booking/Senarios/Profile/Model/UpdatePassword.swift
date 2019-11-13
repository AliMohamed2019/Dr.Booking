// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let updatePassword = try? newJSONDecoder().decode(UpdatePassword.self, from: jsonData)

import Foundation

// MARK: - UpdatePassword
struct UpdatePassword: Codable {
    let status: Int
    let message: String
}
