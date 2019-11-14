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
    
    var sortBy: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Rounded.roundedButton1(button: searchBtn)
        searchBtn.isEnabled = false
        searchTv.delegate = self
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        sortBy = "rate"
       performSegue(withIdentifier: "GoToSearch", sender: self)
    }

    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        sortBy = "all"
        performSegue(withIdentifier: "GoToSearch", sender: self)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSearch" {
            let vc = segue.destination as! SearchResultVC
            vc.modalPresentationStyle = .fullScreen
            vc.searchDoctors(SortBy: sortBy ?? "all", keyWord: searchTv.text ?? "", userId: UserDefault.getId())
        }
    }
}
