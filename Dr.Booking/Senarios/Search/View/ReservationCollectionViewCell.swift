//
//  ReservationCollectionViewCell.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/17/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Alamofire
protocol DidReserve {
    func reservedSuccessfully()
    func failedToReserve(error: AFError)
}

class ReservationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var reservationDay: UILabel!
    @IBOutlet weak var startHour: UILabel!
    @IBOutlet weak var endHour: UILabel!
    
    var date: ReserveDate?
    var delegate: DidReserve?
    @IBAction func reserveButtonPressed(_ sender: UIButton) {
        if let Date = date {
            DispatchQueue.global().async { [weak self] in
                APIClient.addReservation(user_id: UserDefault.getId() , car_id: Date.idUser, car_reservation_date_id: Date.id) { (Result) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        self?.delegate?.reservedSuccessfully()
                    case .failure(let error):
                        print(error)
                        self?.delegate?.failedToReserve(error: error)
                    }
                }
            }
        }
    }
}
