//
//  FavoriteDetailsViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/14/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class FavoriteDetailsViewController: UIViewController {
     var alFavoriteDoctorArray:[Doctor]?

    @IBOutlet weak var doctorFavoriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriteDoctors()
       // configureTableView()
        doctorFavoriteTableView.rowHeight = 280
        // Do any additional setup after loading the view.
    }
    

  func addFavoriteDoctor() {
         APIClient.addFavoriteDoctor(user_id: "78", doctor_id: "29"){(Result) in
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
     
     
     func deleteFavoriteDoctor() {
         APIClient.deleteFavoriteDoctor(user_id: "78", doctor_id: "29"){(Result) in
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
     
     //TODO: Declare configureTableView here:
       func configureTableView()  {
           doctorFavoriteTableView.rowHeight = UITableView.automaticDimension
         doctorFavoriteTableView.estimatedRowHeight = 150.0
       }

 
}

extension FavoriteDetailsViewController: UITableViewDelegate , UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alFavoriteDoctorArray?.count ?? 0
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteDetailsTableViewCell
    cell.doctorImage.sd_setImage(with: URL(string: alFavoriteDoctorArray?[indexPath.row].image ?? ""),
    placeholderImage: UIImage(named: "user"))
    cell.doctorName.text = alFavoriteDoctorArray?[indexPath.row].name ?? ""
    cell.DoctorTitle.text = alFavoriteDoctorArray?[indexPath.row].jobTitle ?? ""
    cell.doctorFees.text = alFavoriteDoctorArray?[indexPath.row].price ?? ""
    cell.doctorFees.text = alFavoriteDoctorArray?[indexPath.row].price ?? ""
    cell.doctorAddress.text = alFavoriteDoctorArray?[indexPath.row].address ?? ""
    return cell
}
}
