//
//  DoctorinformationAndReservationDates.swift
//  Dr.Booking
//
//  Created by Mustafa on 2/13/20.
//  Copyright © 2020 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import Foundation

// MARK: - DoctorinformationAndReservationDates
struct DoctorinformationAndReservationDates: Codable {
    let status: Int
    let dates: [DateElement]?
    let doctor: Doctorinformation
}

// MARK: - DateElement
struct DateElement: Codable {
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
struct Doctorinformation: Codable {
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
