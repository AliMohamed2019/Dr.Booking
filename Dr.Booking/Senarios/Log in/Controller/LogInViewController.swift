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
    
    @IBOutlet weak var stackCenterYConstat: NSLayoutConstraint!
    //MARK: - IBOutlet
    @IBOutlet weak var email: DesignableUITextField!{
        didSet{
            email.delegate = self
            
        }
    }
    @IBOutlet weak var password: DesignableUITextField!{
        didSet{
            password.delegate = self
            
        }
    }
    @IBOutlet weak var logInBtn: UIButton!
    
    var login:Login?
    var failure:Failure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - IBAction
    @IBAction func logInPressed(_ sender: UIButton) {
        getLogin()
    }
    
    //MARK: - Func Login
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
                        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as? TabBar {
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                        
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
    
    
    //MARK: - Func To Save Date in UserDefault
    func setData() {
        UserDefault.setId((self.login?.userData.id)!)
        UserDefault.setName((self.login?.userData.name)!)
        UserDefault.setEmail((self.login?.userData.mail)!)
        UserDefault.setPhone((self.login?.userData.phone)!)
        
    }
    //MARK: - Func to Empty TextFaild
    func clearText()  {
        email.text = ""
        password.text = ""
    }
    //TODO: Declare textFieldDidBeginEditing here:
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.stackCenterYConstat.constant = -80
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    //TODO: Declare textFieldDidEndEditing here:
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.stackCenterYConstat.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordVC {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func regesterButtonPressed(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegesterVC") as? RegesterVC {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
