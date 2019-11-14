//
//  FavoriteDetailsViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/14/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class FavoriteDetailsViewController: UIViewController {
     var alFavoriteDoctorArray:[SearchDoctor]?
     var doctorId = ""
    var favoriteDoctor : FavoriteDoctor?

    @IBOutlet weak var doctorFavoriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriteDoctors()
       // configureTableView()
        doctorFavoriteTableView.rowHeight = 280
        // Do any additional setup after loading the view.
    }
    

  
     
     
     func deleteFavoriteDoctor() {
        APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: "29"){(Result) in
             switch Result {
             case.success(let response):
                 DispatchQueue.main.async {
                     print("aaaaaaaa")
                     print(response)
                 }
             case.failure(let error):
                 DispatchQueue.main.async {
                     print("bbbbbbbbb")
                     print(error.localizedDescription)
                 }
             }
             
         }
     }
     
  
     
     func getFavoriteDoctors() {
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
    cell.doctorFees.text = doctor.price
    cell.doctorAddress.text = doctor.address
    cell.rateOfDoctor.rating = doctor.rating
    cell.doctorId = doctor.id
        if cell.check == 1{
            getFavoriteDoctors()
            print("newwwwwwwwww")

        }
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
