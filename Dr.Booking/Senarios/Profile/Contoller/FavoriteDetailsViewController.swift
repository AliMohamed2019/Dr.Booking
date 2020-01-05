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
    
    var alFavoriteDoctorArray:[Car]?
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
        
        APIClient.getFavoriteCars(user_id: UserDefault.getId()){(Result) in
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
                    APIClient.getFavoriteCarsfailure(user_id: UserDefault.getId()){(Result) in
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
        if let car = alFavoriteDoctorArray?[indexPath.row] {
            cell.CarImage.sd_setImage(with: URL(string: alFavoriteDoctorArray?[indexPath.row].image ?? ""),
                                         placeholderImage: UIImage(named: "user"))
            cell.carName.text = car.name
            cell.carTitle.text = car.jobTitle
            cell.carFees.text = car.price
            cell.carAddress.text = car.address
            cell.rateOfCar.rating = car.rating
            
            cell.delegate = self
            cell.delegateDetails = self
            cell.car = car
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorDetails") as! DoctorDetailsVC
        vc.car = alFavoriteDoctorArray?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension FavoriteDetailsViewController: CarDetailsDelegate {
    func details(id: String, car: Car) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorDetails") as! DoctorDetailsVC
        vc.car = car
        vc.carID = id
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
