//
//  ReservationCollectionViewCell.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/17/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ReservationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var reservationDay: UILabel!
    @IBOutlet weak var startHour: UILabel!
    @IBOutlet weak var endHour: UILabel!
    
    var date: DateElement?

    
    @IBAction func reserveButtonPressed(_ sender: UIButton) {
        if let Date = date {
            DispatchQueue.global().async {
                APIClient.addReservation(user_id: UserDefault.getId() , doctor_id: Date.idUser, docotor_reservation_date_id: Date.id) { (Result) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
