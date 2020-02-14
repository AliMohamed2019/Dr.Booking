

import Foundation

// MARK: - SearchResultModel
struct SearchResultModel: Codable {
    let status: Int
    let doctors: [DoctorSearchResultModel]
}

// MARK: - Doctor
struct DoctorSearchResultModel: Codable {
    let favorite: Int
    let id, name, address: String
    let image: String
    let price, jobTitle, longitude, latitude: String
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case favorite, id, name, address, image, price
        case jobTitle = "job_title"
        case longitude, latitude, rating
    }
}
