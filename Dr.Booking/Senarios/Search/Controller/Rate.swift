//
//  Rate.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
class Rate: UIViewController {

    
    @IBOutlet weak var rateView2: UIView!{
        didSet{
            self.rateView2.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var rateView: UIView!{
        didSet{
            self.rateView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var rateStars: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func rateButtonPressed(_ sender: UIButton) {
    }
    
}
