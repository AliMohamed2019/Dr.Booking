//
//  DoctorDetailsVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView
class DoctorDetailsVC: UIViewController ,NVActivityIndicatorViewable{
    
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorTitle: UILabel!
    @IBOutlet weak var doctorDescreption: UILabel!
    @IBOutlet weak var doctorRate: CosmosView!
    @IBOutlet weak var doctorLocation: UILabel!
    @IBOutlet weak var doctorFees: UILabel!
    @IBOutlet weak var doctorJobTitle: UILabel!
    @IBOutlet weak var reservationCollectionView: UICollectionView!
    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            doctorImage.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "user123"))
            Rounded.roundedImage(imageView: doctorImage)
        }
    }
    
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var hieghtConstraint: NSLayoutConstraint!
    var doctorId: String?
    var doctorinformationAndReservationDates :DoctorinformationAndReservationDates?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getDoctorinformationAndReservationDates()
        
    }
    func deleteDectorFromFavorites(){
        APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self.doctorId ?? "") { (Result) in
            switch Result {
            case .success(let response):
                print(response)
                self.likeBtn.setImage(UIImage(named: "favorite2"), for: .normal)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addDectorToFavorite(){
        APIClient.addFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self.doctorId ?? "" ) { (Result) in
            switch Result {
            case .success(let response):
                print(response)
                self.likeBtn.setImage(UIImage(named: "favorite1"), for: .normal)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if likeBtn.image(for: .normal) == UIImage(named: "favorite1") {
            deleteDectorFromFavorites()
        } else if likeBtn.image(for: .normal) == UIImage(named: "favorite2") {
            addDectorToFavorite()
        }
    }
    
    func updateView(){
        
        navigationItem.title =  doctorinformationAndReservationDates?.doctor.name
        doctorImage.sd_setImage(with: URL(string:  doctorinformationAndReservationDates?.doctor.image ?? ""), placeholderImage: UIImage(named: ""))
        doctorName.text = doctorinformationAndReservationDates?.doctor.name
        doctorTitle.text = doctorinformationAndReservationDates?.doctor.jobTitle
        doctorDescreption.text = doctorinformationAndReservationDates?.doctor.doctorDescription
        doctorRate.rating = doctorinformationAndReservationDates?.doctor.rating ?? 0.0
        doctorFees.text = doctorinformationAndReservationDates?.doctor.price
        doctorLocation.text = doctorinformationAndReservationDates?.doctor.address
        doctorJobTitle.text = doctorinformationAndReservationDates?.doctor.jobTitle
        if doctorinformationAndReservationDates?.doctor.favorite == 0 {
            likeBtn.setImage(UIImage(named: "favorite2"), for: .normal)
        }else if doctorinformationAndReservationDates?.doctor.favorite ==  1 {
            likeBtn.setImage(UIImage(named: "favorite1"), for: .normal)
        }
        
    }
    // get data when select dector
    
    func getDoctorinformationAndReservationDates(){
        self.startAnimating()
        if let doctorId = doctorId {
            DispatchQueue.global().async { [weak self] in
                APIClient.getDoctorinformationAndReservationDates( doctor_id: doctorId,user_id: UserDefault.getId()) { (Result) in
                    switch Result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self!.stopAnimating()
                            print(response)
                            print("success")
                            self?.doctorinformationAndReservationDates = response
                            self?.updateView()
                            self?.reservationCollectionView.reloadData()
                            if self?.reservationCollectionView.numberOfItems(inSection: 0) != 0 {
                                self?.hieghtConstraint.constant = 174
                            }
                        }
                    case.failure(let error):
                        print("failed")
                        self!.stopAnimating()
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
        RateVC.doctorID = doctorId ?? ""
        present(RateVC, animated: true, completion: nil)
    }
    
}

//MARK:- TableView set up
extension DoctorDetailsVC: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctorinformationAndReservationDates?.dates?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! ReservationCollectionViewCell
        if let date = doctorinformationAndReservationDates?.dates?[indexPath.row] {
            cell.reservationDay.text = date.reservationDate
            cell.startHour.text = date.fromTime
            cell.endHour.text = date.toTime
            cell.date = date
            cell.delegteTransfe = self
        }
        return cell
    }
    
    
}

extension DoctorDetailsVC: transferToPopup {
    func transfe(text: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CompleteReservationViewController") as! CompleteReservationViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.msgText = text
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}
