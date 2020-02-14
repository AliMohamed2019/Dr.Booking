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
    var chkSearch : Int?
    var srachText : String?
    var allDectorModel : AllDectorModel?
    var searchResultModel:SearchResultModel?
    var failure:Failure?
    
    
    @IBOutlet weak var TableView: UITableView!{
        didSet{
            TableView.rowHeight = UITableView.automaticDimension
            TableView.estimatedRowHeight = 280
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSearchDector(number: chkSearch!)
        
    }
    
    func getSearchDector(number : Int)   {
        if number == 1 {
            getAllDector()
        }else{
            getSearchDector()
        }
    }
    
    func getAllDector()  {
        self.startAnimating()
        APIClient.getDoctors(user_id: UserDefault.getId()) { (Result) in
            switch Result {
            case .success(let response):
                self.stopAnimating()
                self.allDectorModel = response
                self.TableView.reloadData()
            case .failure(let error):
                self.stopAnimating()
                print(error.localizedDescription)
            }
        }
    }
    
   
    
    
    func getSearchDector(){
        if let srachText = srachText  {
            self.startAnimating()
            APIClient.getSearchedDoctors(search_words: srachText, order_by: "rate", user_id: UserDefault.getId()) { (Result) in
                switch Result {
                case .success(let response):
                    print(response)
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.searchResultModel = response
                        self.TableView.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        print(error.localizedDescription)
                        APIClient.getSearchedDoctorsFailure(search_words:srachText , order_by: "rate", user_id: UserDefault.getId()) { (Result) in
                            switch Result {
                            case .success(let response):
                                print(response)
                                DispatchQueue.main.async {
                                    self.stopAnimating()
                                    self.TableView.reloadData()
                                    Rounded.emptyData(TabelView: self.TableView, View: self.view, MessageText: "البحث غير صحيح")
                                }
                            case .failure(let error):
                                DispatchQueue.main.async {
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
    }
    
    
    
    
    
}

extension SearchResultVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chkSearch == 1 {
            return allDectorModel?.doctors.count ?? 0
        }else {
            return searchResultModel?.doctors.count ?? 0

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchResultTableViewCell
        if chkSearch == 1 {
            if let doctor = allDectorModel?.doctors[indexPath.row] {
                cell.doctorName.text = doctor.name
                cell.doctorFees.text = doctor.price
                cell.DoctorTitle.text = doctor.jobTitle
                cell.doctorAddress.text = doctor.address
                cell.rateView.rating = doctor.rating
                cell.lat = doctor.latitude
                cell.long = doctor.longitude
                cell.doctorImage.sd_setImage(with: URL(string: doctor.image), placeholderImage: UIImage(named: "user"))
                if doctor.favorite == 0 {
                    cell.likeBtn.setImage(UIImage(named: "favorite2"), for: .normal)
                }else if doctor.favorite ==  1 {
                    cell.likeBtn.setImage(UIImage(named: "favorite1"), for: .normal)
                }
                cell.doctorId = doctor.id
                cell.delegate = self
                
            }
            return cell
        }else {
            if let doctor = searchResultModel?.doctors[indexPath.row] {
                cell.doctorName.text = doctor.name
                cell.doctorFees.text = doctor.price
                cell.DoctorTitle.text = doctor.jobTitle
                cell.doctorAddress.text = doctor.address
                cell.rateView.rating = Double(doctor.rating)
                cell.lat = doctor.latitude
                cell.long = doctor.longitude
                cell.doctorImage.sd_setImage(with: URL(string: doctor.image), placeholderImage: UIImage(named: "user"))
                if doctor.favorite == 0 {
                    cell.likeBtn.setImage(UIImage(named: "favorite2"), for: .normal)
                }else if doctor.favorite ==  1 {
                    cell.likeBtn.setImage(UIImage(named: "favorite1"), for: .normal)
                }
                cell.doctorId = doctor.id
                cell.delegate = self
                
                 }
                 return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetails") as! DoctorDetailsVC
        if chkSearch == 1 {
            vc.doctorId = allDectorModel?.doctors[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        }else {
            vc.doctorId = searchResultModel?.doctors[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
    
}

extension SearchResultVC: DectorDetailsDelegate {
  
    
    func details(id: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetails") as! DoctorDetailsVC
        if chkSearch == 1 {
            vc.doctorId = id
            navigationController?.pushViewController(vc, animated: true)
        }else {
            vc.doctorId = id
            navigationController?.pushViewController(vc, animated: true)
            
        }
        

    }
    
    
    
    
}
