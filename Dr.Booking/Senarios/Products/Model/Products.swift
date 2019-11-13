// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let products = try? newJSONDecoder().decode(Products.self, from: jsonData)

import Foundation

// MARK: - Products
struct Products: Codable {
    let status: Int
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let id, price, name, benefits: String
    let productDescription: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, price, name, benefits
        case productDescription = "description"
        case image
    }
}
