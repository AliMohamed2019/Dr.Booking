//
//  RegesterVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/11/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class RegesterVC: UIViewController {

    @IBOutlet weak var name: DesignableUITextField!
    @IBOutlet weak var passwrod: DesignableUITextField!
    @IBOutlet weak var phone: DesignableUITextField!
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var regesterBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        register()
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
    }
    
    
    func register(){
        if let name = name.text , let mail = email.text , let phone = phone.text , let pass = passwrod.text{
        APIClient.register(user_name: name , mail: mail, phone: phone, pass: pass){(Result) in
            switch Result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("aaaaaaaa")
                    print(response)
               }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("bbbbbbbbb")
                    print(error.localizedDescription)
                    APIClient.registerfailure(user_name: name , mail: mail, phone: phone, pass: pass) {(Result) in
                    switch Result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            print("aaaaaaaa")
                            print(response)
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
        }
    }
    
    
    
    
    
    
    
    
}
