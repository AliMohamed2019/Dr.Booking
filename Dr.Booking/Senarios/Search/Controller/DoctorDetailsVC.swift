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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Rounded.roundedImage(imageView: doctorImage)
    }

    @IBAction func likeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func rateButtonPressed(_ sender: UIButton) {
    }
    
}
