//
//  ForgotPasswordVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class ForgotPasswordVC: UIViewController , NVActivityIndicatorViewable{
    //MARK: - IBOutlet
    
    @IBOutlet weak var email: DesignableUITextField!{didSet{ email.delegate = self }}
    @IBOutlet weak var submitBtn: UIButton!
    
    var forgetpass:ForgetPass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - IBAction
    
    @IBAction func changePassword(_ sender: UIButton) {
        getForgotPassword()
    }
    
    
    //MARK: - Func Forgot Password
    func getForgotPassword(){
        if let mail = email.text {
            self.startAnimating()
            APIClient.forgetPass(user_email: mail) { (Result) in
                switch Result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        print(response)
                        self.forgetpass = response
                        Alert.show("Error", massege: self.forgetpass!.message, context: self)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        print(error.localizedDescription)
                        
                    }
                }
            }
        }
    }
    
}
