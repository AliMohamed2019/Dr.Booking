// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let registerFailure = try? newJSONDecoder().decode(RegisterFailure.self, from: jsonData)

import Foundation

// MARK: - RegisterFailure
struct Failure: Codable {
    let status: Int
    let message: String
}



