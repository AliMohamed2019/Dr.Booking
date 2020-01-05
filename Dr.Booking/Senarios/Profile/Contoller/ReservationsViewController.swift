//
//  ReservationsViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/17/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class ReservationsViewController: UIViewController , NVActivityIndicatorViewable{
    @IBOutlet weak var reservationsTableVie: UITableView!{
        didSet{
            reservationsTableVie.rowHeight = UITableView.automaticDimension
            reservationsTableVie.estimatedRowHeight = 300
        }
    }
    
    var userReservationsArray:[Reservation]?
    var failure:Failure?
    
    var carID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserReservations()
        
    }
    
    
    
    
    func getUserReservations() {
        self.startAnimating()
        APIClient.view_reservations(user_id: UserDefault.getId()) { (Result) in
            switch Result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    self.userReservationsArray = response.reservations
                    self.reservationsTableVie.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    print(error.localizedDescription)
                    APIClient.view_reservationsFailure(user_id: UserDefault.getId()) { (Result) in
                        switch Result {
                        case .success(let response):
                            DispatchQueue.main.async {
                                self.stopAnimating()
                                self.failure = response
                                Rounded.emptyData(TabelView: self.reservationsTableVie, View: self.view, MessageText: self.failure!.message)
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.stopAnimating()
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
}

extension ReservationsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userReservationsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReservationDetailsTableViewCell
        if let reservation = userReservationsArray?[indexPath.row] {
            cell.carImage.sd_setImage(with: URL(string: userReservationsArray?[indexPath.row].image ?? ""),
                                         placeholderImage: UIImage(named: "user"))
            cell.carName.text = reservation.car
            cell.carTitle.text = reservation.jobTitle
            cell.carFees.text = reservation.price
            cell.carAddress.text = reservation.place
            cell.rateOfAdd.rating = reservation.rate
            cell.carDate.text = "\(reservation.date ?? ""), من الساعة  \(reservation.timeFrom ?? "") الي \( reservation.timeTo ?? "")"
            cell.location = reservation
            cell.carId = reservation.carID
            cell.delegate = self
            
            
            
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        carID = userReservationsArray?[indexPath.row].carID
        if let doc = carID {
            print(doc)
            let vc = storyboard?.instantiateViewController(identifier: "DectorDataViewController") as! CarDataViewController
            vc.carID = doc
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


extension ReservationsViewController: DectorsDetailsProtcolDelegate {
    func details(id: String) {
        let vc = storyboard?.instantiateViewController(identifier: "DectorDataViewController") as! CarDataViewController
        vc.carID = id
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}



