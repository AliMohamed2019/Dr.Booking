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
    var userReservationsArray:[Reservation]?
    var failure:Failure?

    @IBOutlet weak var reservationsTableVie: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserReservations()
        
        reservationsTableVie.rowHeight = UITableView.automaticDimension
        reservationsTableVie.estimatedRowHeight = 300
        // Do any additional setup after loading the view.
    }

   func getUserReservations() {
    self.startAnimating()
           APIClient.view_reservations(user_id: UserDefault.getId()) { (Result) in
                   switch Result {
                   case .success(let response):
                       DispatchQueue.main.async {
                        self.stopAnimating()
                           print("aaaaaaaa")
                           print(response)
                           self.userReservationsArray = response.reservations
                           self.reservationsTableVie.reloadData()
                          
                      }
                   case .failure(let error):
                         DispatchQueue.main.async {
                            self.stopAnimating()
                           print("bbbbbbbbb")
                           print(error.localizedDescription)
                           APIClient.view_reservationsFailure(user_id: UserDefault.getId()) { (Result) in
                               switch Result {
                               case .success(let response):
                                   DispatchQueue.main.async {
                                    self.stopAnimating()
                                       print("aaaaaaaa")
                                       print(response)
                                       self.failure = response
                                    Rounded.emptyData(TabelView: self.reservationsTableVie, View: self.view, MessageText: self.failure!.message)

                                   //    Alert.show("Error", massege: self.failure!.message, context: self)
                                  }
                               case .failure(let error):
                                   DispatchQueue.main.async {
                                    self.stopAnimating()
                                       print("bbbbbbbbb")
                                       print(error.localizedDescription)
                                   }}}
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
         cell.doctorImage.sd_setImage(with: URL(string: userReservationsArray?[indexPath.row].image ?? ""),
         placeholderImage: UIImage(named: "user"))
         cell.doctorName.text = reservation.doctor
         cell.DoctorTitle.text = reservation.jobTitle
         cell.doctorFees.text = reservation.price
         cell.doctorAddress.text = reservation.place
         cell.rateOfDoctor.rating = reservation.rate
            cell.doctorDate.text = "\(reservation.date ?? ""), من الساعة  \(reservation.timeFrom ?? "") الي \( reservation.timeTo ?? "")"
        
      
         }
         return cell
    
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = storyboard?.instantiateViewController(identifier: "DoctorDetails") as! DoctorDetailsVC
        
            navigationController?.pushViewController(vc, animated: true)

           
           
         
        
           //  vc.productID = userProductsArray?[indexPath.row].id ?? ""
          
       }
}
