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

    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorTitle: UILabel!
    @IBOutlet weak var doctorDescreption: UILabel!
    @IBOutlet weak var doctorRate: CosmosView!
    @IBOutlet weak var doctorLocation: UILabel!
    @IBOutlet weak var doctorFees: UILabel!
    @IBOutlet weak var doctorJobTitle: UILabel!
    @IBOutlet weak var reservationCollectionView: UICollectionView!
    
    @IBOutlet weak var likeBtn: UIButton!{
        didSet{
            self.likeBtn.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
    }
    @IBOutlet weak var hieghtConstraint: NSLayoutConstraint!
    
    var doctor: SearchDoctor?
    var userID: String?
    var reservDates: [ReserveDate]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getReservations()
        updateView()
        
    }
    
    func updateView(){
        
        navigationItem.title = doctor?.name
        
        if reservationCollectionView.numberOfItems(inSection: 0) == 0 {
            hieghtConstraint.constant = 0
        }
        
        Rounded.roundedImage(imageView: doctorImage)
        doctorImage.sd_setImage(with: URL(string: doctor?.image ?? ""), placeholderImage: UIImage(named: ""))
        doctorName.text = doctor?.name
        doctorTitle.text = doctor?.jobTitle
        doctorDescreption.text = doctor?.doctorDescription
        doctorRate.rating = doctor?.rating ?? 0.0
        doctorFees.text = doctor?.price
        doctorLocation.text = doctor?.address
        doctorJobTitle.text = doctor?.jobTitle
        
        if doctor?.favorite == 1 {
            likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }
    }
    
    func getReservations(){
        if let doctorID = doctor?.id {
            DispatchQueue.global().async { [weak self] in
                APIClient.getReservation(user_id: UserDefault.getId(), doctor_id: doctorID) { (Result) in
                    switch Result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            print("success")
                            self?.reservDates = response.dates
                            self?.reservationCollectionView.reloadData()
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
                APIClient.addFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self?.doctor?.id ?? "") { (Result) in
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
                APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self?.doctor?.id ?? "") { (Result) in
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
//        RateVC.modalPresentationStyle = .fullScreen
        RateVC.doctorID = doctor?.id ?? ""
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
