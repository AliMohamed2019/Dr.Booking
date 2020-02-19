//
//  ReservationCollectionViewCell.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/17/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
protocol transferToPopup {
    func transfe(text : String)
    
    
}
class ReservationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var reservationDay: UILabel!
    @IBOutlet weak var startHour: UILabel!
    @IBOutlet weak var endHour: UILabel!
    
    var date: DateElement?
    var delegteTransfe : transferToPopup?

    
    @IBAction func reserveButtonPressed(_ sender: UIButton) {
        if let Date = date {
            DispatchQueue.global().async {
                print(self.date)
                APIClient.addReservation(user_id: UserDefault.getId() , doctor_id: Date.idUser, docotor_reservation_date_id: Date.id) { (Result) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        self.delegteTransfe?.transfe(text: response.message)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
