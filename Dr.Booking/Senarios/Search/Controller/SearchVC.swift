//
//  SearchVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class SearchVC: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTv: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Rounded.roundedButton1(button: searchBtn)
        searchTv.delegate = self
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
    }

     
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
          if searchTv.text != nil {
                  searchBtn.backgroundColor = #colorLiteral(red: 0.5216588974, green: 0.8082630634, blue: 0.2478611171, alpha: 1)
              } else {
                  searchBtn.backgroundColor = .lightGray
              }
    }
}
