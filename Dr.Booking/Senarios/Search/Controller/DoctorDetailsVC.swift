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
    
    var doctor: SearchDoctor?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
    }
    func updateView(){
        navigationItem.title = doctor?.name
        Rounded.roundedImage(imageView: doctorImage)
        doctorImage.sd_setImage(with: URL(string: doctor?.image ?? ""), placeholderImage: UIImage(named: ""))
        doctorName.text = doctor?.name
        doctorTitle.text = doctor?.jobTitle
        doctorDescreption.text = doctor?.doctorDescription
        doctorRate.rating = doctor?.rating ?? 0.0
        doctorFees.text = doctor?.price
            
        
    }

    @IBAction func likeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func rateButtonPressed(_ sender: UIButton) {
        let RateVC = storyboard?.instantiateViewController(withIdentifier: "Rate") as! Rate
        RateVC.modalPresentationStyle = .fullScreen
        RateVC.doctorID = doctor?.id ?? ""
        present(RateVC, animated: true, completion: nil)
    }
    
}
