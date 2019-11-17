//
//  FavoriteDetailsViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/14/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class FavoriteDetailsViewController: UIViewController , CustomCellUpdater {
    
       @IBOutlet weak var doctorFavoriteTableView: UITableView!
    
       var alFavoriteDoctorArray:[SearchDoctor]?
       var failure:Failure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriteDoctors()
        doctorFavoriteTableView.estimatedRowHeight = 300
        doctorFavoriteTableView.rowHeight = UITableView.automaticDimension
   
    }
     
     func getFavoriteDoctors() {
        
        self.alFavoriteDoctorArray?.removeAll()
        
        APIClient.getFavoriteDoctors(user_id: UserDefault.getId()){(Result) in
               switch Result {
               case.success(let response):
                   DispatchQueue.main.async {
                      print("aaaaaaaa")
                      print(response)
                    self.alFavoriteDoctorArray = response.doctors
                    self.doctorFavoriteTableView.reloadData()
                   }
               case.failure(let error):
                   DispatchQueue.main.async {
                       print("bbbbbbbbb")
                       print(error.localizedDescription)
                    APIClient.getFavoriteDoctorsfailure(user_id: UserDefault.getId()){(Result) in
                     switch Result {
                     case.success(let response):
                         DispatchQueue.main.async {
                             print("aaaaaaaa")
                             print(response)
                            self.failure = response
                            self.doctorFavoriteTableView.reloadData()
                            Alert.show("Error", massege: self.failure!.message, context: self)

                         }
                     case.failure(let error):
                         DispatchQueue.main.async {
                             print("bbbbbbbbb")
                             print(error.localizedDescription)
                         }
                         }
                     }
                   
                   }
               }
               
           }
       }
}



extension FavoriteDetailsViewController: UITableViewDelegate , UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alFavoriteDoctorArray?.count ?? 0
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteDetailsTableViewCell
    if let doctor = alFavoriteDoctorArray?[indexPath.row] {
    cell.doctorImage.sd_setImage(with: URL(string: alFavoriteDoctorArray?[indexPath.row].image ?? ""),
    placeholderImage: UIImage(named: "user"))
    cell.doctorName.text = doctor.name
    cell.DoctorTitle.text = doctor.jobTitle
    cell.doctorFees.text = doctor.price
    cell.doctorAddress.text = doctor.address
    cell.rateOfDoctor.rating = doctor.rating
    cell.doctorId = doctor.id
    cell.delegate = self
 
    }
    return cell
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorDetails") as! DoctorDetailsVC
        
        vc.doctor = alFavoriteDoctorArray?[indexPath.row]
       //  vc.productID = userProductsArray?[indexPath.row].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
