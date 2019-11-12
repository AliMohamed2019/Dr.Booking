//
//  EditProfileVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.profileImage)
        }
    }
    
    @IBOutlet weak var name: DesignableUITextField!
    @IBOutlet weak var phone: DesignableUITextField!
    @IBOutlet weak var email: DesignableUITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func editProfile(_ sender: UIButton) {
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
    }
    
}
