//
//  SearchResultVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
class SearchResultVC: UIViewController {
    
    
    var doctorsArray: [SearchDoctor]?
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.rowHeight = UITableView.automaticDimension
        TableView.estimatedRowHeight = 280
        
        
        
    }
    
    func searchDoctors(SortBy:String , keyWord: String , userId: String){
        if SortBy == "all" {
            APIClient.getDoctors(user_id: userId) { (Result) in
                switch Result {
                case .success(let response):
                    print("success")
                    self.doctorsArray = response.doctors
                    self.TableView.reloadData()
                case .failure(let error):
                    print("error")
                    print(error.localizedDescription)
                }
            }
        } else {
            APIClient.getSearchedDoctors(search_words: keyWord, order_by: SortBy, user_id: userId) { (Result) in
                switch Result {
                case .success(let response):
                    print("===============================")
                    print(response)
                case.failure(let error):
                    print("===============================")
                    print(error.localizedDescription)
                    APIClient.getSearchedDoctorsFailure(search_words: keyWord, order_by: SortBy, user_id: userId) { (Result) in
                        switch Result {
                            case .success(let response):
                                print("===============================")
                                print(response)
                                self.TableView.reloadData()
                                Rounded.emptyData(TabelView: self.TableView, View: self.view, MessageText: "No Doctors Available")
                            case.failure(let error):
                                print("===============================")
                                print(error.localizedDescription)
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
            if doctor.favorite == 1 {
                cell.likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
            }
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 320
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorDetails") as! DoctorDetailsVC
        vc.doctor = doctorsArray?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
