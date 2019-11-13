//
//  Doctor.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/13/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import Foundation
import RealmSwift

class Doctor: Object {
    @objc dynamic var Name: String = ""
    @objc dynamic var Fees: Int = 0
}
