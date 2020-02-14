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
    
    var favoriteDoctorForMe:FavoriteDoctorForMe?
    var failure:Failure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doctorFavoriteTableView.estimatedRowHeight = 300
        doctorFavoriteTableView.rowHeight = UITableView.automaticDimension
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getFavoriteDoctors()
    }
    
    func getFavoriteDoctors() {
        self.startAnimating()
        APIClient.getFavoriteDoctors(user_id: UserDefault.getId()){(Result) in
            switch Result {
            case.success(let response):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    print("aaaaaaaa")
                    print(response)
                    self.favoriteDoctorForMe = response
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
        return favoriteDoctorForMe?.doctors.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteDetailsTableViewCell
        if let doctor = favoriteDoctorForMe?.doctors[indexPath.row] {
            cell.doctorImage.sd_setImage(with: URL(string: favoriteDoctorForMe?.doctors[indexPath.row].image ?? ""),
                                         placeholderImage: UIImage(named: "user"))
            cell.doctorName.text = doctor.name
            cell.DoctorTitle.text = doctor.jobTitle
            cell.doctorFees.text = doctor.price
            cell.doctorAddress.text = doctor.address
            cell.rateOfDoctor.rating = doctor.rating
            cell.lat = doctor.latitude
            cell.long = doctor.longitude
            cell.doctorId = doctor.id
            cell.delegate = self
            cell.delegateDetails = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetails") as! DoctorDetailsVC
        vc.doctorId =  favoriteDoctorForMe?.doctors[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension FavoriteDetailsViewController: DectorDetailsDelegate {
    func details(id: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetails") as! DoctorDetailsVC
        vc.doctorId = id
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
