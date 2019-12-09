//
//  DectorDataViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 12/9/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView


class DectorDataViewController: UIViewController , NVActivityIndicatorViewable {
    //outlet
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorTitle: UILabel!
    @IBOutlet weak var doctorDescreption: UILabel!
    @IBOutlet weak var doctorRate: CosmosView!
    @IBOutlet weak var doctorLocation: UILabel!
    @IBOutlet weak var doctorFees: UILabel!
    @IBOutlet weak var doctorJobTitle: UILabel!
    
    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            doctorImage.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "user123"))
            Rounded.roundedImage(imageView: doctorImage)
        }
    }
    
    @IBOutlet weak var likeBtn: UIButton!{
        didSet{
            self.likeBtn.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    var doctorID: String?
    var doctor: DoctorV?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDectorDate()
        // updateView()
        
        // Do any additional setup after loading the view.
    }
    
    func updateView(){
        
        navigationItem.title =  doctor?.name
        
        
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
    
    // get data when select dector
    
    func getDectorDate(){
         self.startAnimating()
        if let doctorID = doctorID {
            DispatchQueue.global().async { [weak self] in
                APIClient.viewDoctor( doctor_id: doctorID,user_id: UserDefault.getId()) { (Result) in
                    switch Result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self!.stopAnimating()
                            print("success")
                            
                            self?.doctor = response.doctor
                            self?.updateView()
                            
                            
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
    
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if likeBtn.currentBackgroundImage == UIImage(named: "heart") {
            likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
            
            DispatchQueue.main.async { [weak self] in
                APIClient.addFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self?.doctorID ?? "") { (Result) in
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
                APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self?.doctorID ?? "") { (Result) in
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
        RateVC.doctorID = doctorID ?? ""
        present(RateVC, animated: true, completion: nil)
    }
    
    
}
