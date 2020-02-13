//
//  SearchResultVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView
class SearchResultVC: UIViewController , NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var TableView: UITableView!{
        didSet{
            TableView.rowHeight = UITableView.automaticDimension
            TableView.estimatedRowHeight = 280
        }
    }
    
    var doctorsArray: [Doctor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startAnimating()
    }
    
    func searchDoctors(SortBy:String , keyWord: String , userId: String){
        
        if SortBy == "all" {
            APIClient.getDoctors(user_id: userId) { (Result) in
                switch Result {
                case .success(let response):
                    self.stopAnimating()
                    self.doctorsArray = response.doctors
                    self.TableView.reloadData()
                case .failure(let error):
                    self.startAnimating()
                    print(error.localizedDescription)
                }
            }
        } else {
            APIClient.getSearchedDoctors(search_words: keyWord, order_by: SortBy, user_id: userId) { (Result) in
                switch Result {
                case .success( _):
                    self.stopAnimating()
                case.failure(let error):
                    self.stopAnimating()
                    print(error.localizedDescription)
                    APIClient.getSearchedDoctorsFailure(search_words: keyWord, order_by: SortBy, user_id: userId) { (Result) in
                        switch Result {
                        case .success( _):
                            self.stopAnimating()
                            self.TableView.reloadData()
                            Rounded.emptyData(TabelView: self.TableView, View: self.view, MessageText: "البحث غير صحيح")
                        case.failure(let error):
                            self.stopAnimating()
                            print(error.localizedDescription)
                            Rounded.emptyData(TabelView: self.TableView, View: self.view, MessageText: "البحث غير صحيح")
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
}

extension SearchResultVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchResultTableViewCell
        if let doctor = doctorsArray?[indexPath.row] {
            cell.doctorName.text = doctor.name
            cell.doctorFees.text = doctor.price
            cell.DoctorTitle.text = doctor.jobTitle
            cell.doctorAddress.text = doctor.address
            cell.rateView.rating = doctor.rating
            
            cell.doctorImage.sd_setImage(with: URL(string: doctor.image), placeholderImage: UIImage(named: "user"))
            cell.doctor = doctor
            cell.delegate = self
            if doctor.favorite == 1 {
                cell.likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetails") as! DoctorDetailsVC
        vc.doctor = doctorsArray?[indexPath.row]
        vc.doctorID = doctorsArray?[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchResultVC: DectorDetailsDelegate {
    func details(id: String, doctor: Doctor) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetails") as! DoctorDetailsVC
        vc.doctor = doctor
        vc.doctorID = id
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}
