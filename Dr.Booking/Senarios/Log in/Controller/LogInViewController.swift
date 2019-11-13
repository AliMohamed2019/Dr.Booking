//
//  ViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/10/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var password: DesignableUITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func logInPressed(_ sender: UIButton) {
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
    }
    
    @IBAction func regesterButtonPressed(_ sender: UIButton) {
    }
    
    
    
    
    func login(){
        if let mail = email.text , let pass = password.text {
        APIClient.login(mail: mail, password: pass) { (Result) in
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

