//
//  FavoriteDoctorForMe.swift
//  Dr.Booking
//
//  Created by Mustafa on 2/14/20.
//  Copyright © 2020 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import Foundation
// MARK: - FavoriteDoctorForMe
struct FavoriteDoctorForMe: Codable {
    let status: Int
    let doctors: [FavoriteDoctorData]
}

// MARK: - Doctor
struct FavoriteDoctorData: Codable {
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
