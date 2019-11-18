//
//  ChangePasswordVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ChangePasswordVC: UIViewController  , NVActivityIndicatorViewable{
    var updatePassword:UpdatePassword?

    @IBOutlet weak var currentPassword: DesignableUITextField!
    @IBOutlet weak var newPassword: DesignableUITextField!
    @IBOutlet weak var comfirmPassword: DesignableUITextField!
    @IBOutlet weak var changBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("dcfvgbnm,l.")

        
    }
    
    @IBAction func changePasswordPressed(_ sender: UIButton) {
        print("aaaaaafghjm,dfghnm,")
        getupdatePassword()
        
    }
    
    
    func getupdatePassword(){
        self.startAnimating()
        if let currentPassword = currentPassword.text ,let newPassword = newPassword.text , let comfirmPassword = comfirmPassword.text{
            APIClient.updatePassword(user_id: UserDefault.getId(), Current_Password: currentPassword, New_Password: newPassword, ReType_New_Password: comfirmPassword) { (Result) in
            switch Result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    print("aaaaaaaa")
                    print(response)
                    self.updatePassword = response
                    Alert.show("", massege: self.updatePassword!.message ,context: self)
                    self.emptyText()
               }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    print("bbbbbbbbb")
                    print(error.localizedDescription)
                   
                }
            }
            }
        }
            
    }
    
    func emptyText()  {
        currentPassword.text = ""
        newPassword.text = ""
        comfirmPassword.text = ""
        
        
    }
    
}
