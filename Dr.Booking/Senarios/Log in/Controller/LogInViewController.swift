//
//  ViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/10/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class LogInViewController: UIViewController , NVActivityIndicatorViewable{
    
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var password: DesignableUITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    var login:Login?
    var failure:Failure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        getLogin()
    }
    
    func getLogin(){
        if let mail = email.text , let pass = password.text {
            self.startAnimating()
            APIClient.login(mail: mail, password: pass) { (Result) in
                switch Result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.login = response
                        self.setData()
                        self.clearText()
                        self.performSegue(withIdentifier: "GoToTapBar", sender: self)
                   }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        print(error.localizedDescription)
                        APIClient.loginfailure(mail: mail, password: pass) { (Result) in
                            switch Result {
                                case .success(let response):
                                    DispatchQueue.main.async {
                                        self.stopAnimating()
                                        self.failure = response
                                        Alert.show("خطاء", massege: self.failure!.message, context: self)
                                        
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTapBar" {
         let vc = segue.destination as! TabBar
         vc.modalPresentationStyle = .fullScreen
        }
    }
    
    func setData() {
        UserDefault.setId((self.login?.userData.id)!)
        UserDefault.setName((self.login?.userData.name)!)
        UserDefault.setEmail((self.login?.userData.mail)!)
        UserDefault.setPhone((self.login?.userData.phone)!)
          
    }
    
    func clearText()  {
        email.text = ""
        password.text = ""
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
    }
    
    @IBAction func regesterButtonPressed(_ sender: UIButton) {
    }
}

