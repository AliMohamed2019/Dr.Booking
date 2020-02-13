//
//  FavoriteDetailsViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/14/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class FavoriteDetailsViewController: UIViewController , CustomCellUpdater  , NVActivityIndicatorViewable{
    
    @IBOutlet weak var doctorFavoriteTableView: UITableView!
    
    var alFavoriteDoctorArray:[Doctor]?
    var failure:Failure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriteDoctors()
        doctorFavoriteTableView.estimatedRowHeight = 300
        doctorFavoriteTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func getFavoriteDoctors() {
        self.startAnimating()
        
        self.alFavoriteDoctorArray?.removeAll()
        
        APIClient.getFavoriteDoctors(user_id: UserDefault.getId()){(Result) in
            switch Result {
            case.success(let response):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    print("aaaaaaaa")
                    print(response)
                    self.alFavoriteDoctorArray = response.doctors
                    self.doctorFavoriteTableView.reloadData()
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    print("bbbbbbbbb")
                    print(error.localizedDescription)
                    APIClient.getFavoriteDoctorsfailure(user_id: UserDefault.getId()){(Result) in
                        switch Result {
                        case.success(let response):
                            DispatchQueue.main.async {
                                self.stopAnimating()
                                print("aaaaaaaa")
                                print(response)
                                self.failure = response
                                self.doctorFavoriteTableView.reloadData()
                                Rounded.emptyData(TabelView: self.doctorFavoriteTableView, View: self.view, MessageText: self.failure!.message)
                                //  Alert.show("Error", massege: self.failure!.message, context: self)
                                
                            }
                        case.failure(let error):
                            DispatchQueue.main.async {
                                self.stopAnimating()
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
            
            cell.delegate = self
            cell.delegateDetails = self
            cell.doctor = doctor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetails") as! DoctorDetailsVC
        vc.doctor = alFavoriteDoctorArray?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension FavoriteDetailsViewController: DectorDetailsDelegate {
    func details(id: String, doctor: Doctor) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetails") as! DoctorDetailsVC
        vc.doctor = doctor
        vc.doctorID = id
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
