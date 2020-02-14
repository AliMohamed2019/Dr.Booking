//
//  SearchVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SearchVC: UIViewController, NVActivityIndicatorViewable {
   
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTv: UITextField!    
    override func viewDidLoad() {
        super.viewDidLoad()
        Rounded.roundedButton1(button: searchBtn)
        searchBtn.isEnabled = false
        searchTv.delegate = self
        
    }
    
    
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let searchText = searchTv.text  {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultVC {
                vc.modalPresentationStyle = .fullScreen
                vc.chkSearch = 2
                vc.srachText = searchText
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultVC {
            vc.modalPresentationStyle = .fullScreen
            vc.chkSearch = 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func searchTextfieldIsEditing(_ sender: UITextField) {
        if sender.text != "" {
            searchBtn.backgroundColor = #colorLiteral(red: 0.5216588974, green: 0.8082630634, blue: 0.2478611171, alpha: 1)
            searchBtn.isEnabled = true
        }else {
            searchBtn.backgroundColor = .lightGray
            searchBtn.isEnabled = false
        }
    }
    
    
}
