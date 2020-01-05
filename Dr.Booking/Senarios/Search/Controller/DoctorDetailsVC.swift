//
//  DoctorDetailsVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
class DoctorDetailsVC: UIViewController {
    
    @IBOutlet weak var addName: UILabel!
    @IBOutlet weak var addTitle: UILabel!
    @IBOutlet weak var Descreption: UILabel!
    @IBOutlet weak var addRate: CosmosView!
    @IBOutlet weak var carLocation: UILabel!
    @IBOutlet weak var addFees: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var reservationCollectionView: UICollectionView!
    @IBOutlet weak var carImage: UIImageView!{
        didSet{
            carImage.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "user123"))
            Rounded.roundedImage(imageView: carImage)
        }
    }
    
    
    @IBOutlet weak var likeBtn: UIButton!{
        didSet{
            self.likeBtn.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
    }
    @IBOutlet weak var hieghtConstraint: NSLayoutConstraint!
    
    var car: Car?
    var userID: String?
    var carID: String?
    var reservDates: [ReserveDate]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getReservations()
        updateView()
    }
    
    func updateView(){
        
        navigationItem.title =  car?.name
        
        if reservationCollectionView.numberOfItems(inSection: 0) == 0 {
            hieghtConstraint.constant = 0
        }
        
        carImage.sd_setImage(with: URL(string: car?.image ?? ""), placeholderImage: UIImage(named: ""))
        addName.text = car?.name
        addTitle.text = car?.jobTitle
        Descreption.text = car?.doctorDescription
        addRate.rating = car?.rating ?? 0.0
        addFees.text = car?.price
        carLocation.text = car?.address
        carModel.text = car?.jobTitle
        
        if car?.favorite == 1 {
            likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }
    }
    
    func getReservations(){
        if let carId = carID {
            DispatchQueue.global().async { [weak self] in
                APIClient.getReservation( car_id: carId,user_id: UserDefault.getId()) { (Result) in
                    switch Result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            print("success")
                            self?.reservDates = response.dates
                            self?.car = response.doctor
                            
                            self?.reservationCollectionView.reloadData()
                            self?.updateView()
                            if self?.reservationCollectionView.numberOfItems(inSection: 0) != 0 {
                                self?.hieghtConstraint.constant = 174
                            }
                            
                        }
                    case.failure(let error):
                        print("failed")
                        print(error.localizedDescription)
                        
                    }
                }
            }
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if likeBtn.currentBackgroundImage == UIImage(named: "heart") {
            likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
            
            DispatchQueue.main.async { [weak self] in
                APIClient.addFavoriteCar(user_id: UserDefault.getId(), car_id: self?.car?.id ?? "") { (Result) in
                    switch Result {
                    case .success(let response):
                        print(response)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
        } else {
            likeBtn.setBackgroundImage(UIImage(named: "heart"), for: .normal)
            
            DispatchQueue.main.async { [weak self] in
                APIClient.deleteFavoriteCar(user_id: UserDefault.getId(), car_id: self?.car?.id ?? "") { (Result) in
                    switch Result {
                    case .success(let response):
                        print(response)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    //MARK:- show RateVc
    @IBAction func rateButtonPressed(_ sender: UIButton) {
        let RateVC = storyboard?.instantiateViewController(withIdentifier: "Rate") as! Rate
        RateVC.modalPresentationStyle = .overFullScreen
        RateVC.carID = car?.id ?? ""
        present(RateVC, animated: true, completion: nil)
    }
    
}

//MARK:- TableView set up
extension DoctorDetailsVC: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reservDates?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! ReservationCollectionViewCell
        if let date = reservDates?[indexPath.row] {
            cell.reservationDay.text = date.reservationDate
            cell.startHour.text = date.fromTime
            cell.endHour.text = date.toTime
            cell.date = date
        }
        return cell
    }
    
    
}
