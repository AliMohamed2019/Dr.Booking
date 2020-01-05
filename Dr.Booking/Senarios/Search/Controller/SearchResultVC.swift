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
    
    var CarsArray: [Car]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startAnimating()
    }
    
    func searchCars(SortBy:String , keyWord: String , userId: String){
        
        if SortBy == "all" {
            APIClient.getCars(user_id: userId) { (Result) in
                switch Result {
                case .success(let response):
                    self.stopAnimating()
                    self.CarsArray = response.doctors
                    self.TableView.reloadData()
                case .failure(let error):
                    self.startAnimating()
                    print(error.localizedDescription)
                }
            }
        } else {
            APIClient.getSearchedCars(search_words: keyWord, order_by: SortBy, user_id: userId) { (Result) in
                switch Result {
                case .success( _):
                    self.stopAnimating()
                case.failure(let error):
                    self.stopAnimating()
                    print(error.localizedDescription)
                    APIClient.getSearchedCarsFailure(search_words: keyWord, order_by: SortBy, user_id: userId) { (Result) in
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
        return CarsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchResultTableViewCell
        if let car = CarsArray?[indexPath.row] {
            cell.addName.text = car.name
            cell.addFees.text = car.price
            cell.addTitle.text = car.jobTitle
            cell.carAddress.text = car.address
            cell.rateView.rating = car.rating
            
            cell.CarImage.sd_setImage(with: URL(string: car.image), placeholderImage: UIImage(named: "user"))
            cell.car = car
            cell.delegate = self
            if car.favorite == 1 {
                cell.likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorDetails") as! DoctorDetailsVC
        vc.car = CarsArray?[indexPath.row]
        vc.carID = CarsArray?[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchResultVC: CarDetailsDelegate {
    func details(id: String, car: Car) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorDetails") as! DoctorDetailsVC
        vc.car = car
        vc.carID = id
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}
