//
//  ForgotPasswordVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    var forgetpass:ForgetPass?
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func changePassword(_ sender: UIButton) {
        getForgotPassword()
    }
    

    func getForgotPassword(){
         if let mail = email.text  {
         APIClient.forgetPass(user_email: mail) { (Result) in
             switch Result {
             case .success(let response):
                 DispatchQueue.main.async {
                     print("aaaaaaaa")
                     print(response)
                     self.forgetpass = response
                    Alert.show("Error", massege: self.forgetpass!.message, context: self)
                }
             case .failure(let error):
                 DispatchQueue.main.async {
                     print("bbbbbbbbb")
                     print(error.localizedDescription)
                    
                 }
             }
             }
         }
             
     }
    
    
    
}
