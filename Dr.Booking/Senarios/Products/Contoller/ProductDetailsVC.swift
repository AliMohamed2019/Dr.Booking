//
//  ProductDetailsVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var descreptionTitle: UILabel!
    @IBOutlet weak var descreption: UITextView!
    @IBOutlet weak var benefitsTitle: UILabel!
    @IBOutlet weak var benefits: UITextView!
    
    @IBOutlet weak var imageConst: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func buyProduct(_ sender: UIButton) {
        
        
    }
    
}
