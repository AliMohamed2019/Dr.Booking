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
        performSegue(withIdentifier: "GoToSearch", sender: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchBtn.backgroundColor = .blue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSearch" {
            let vc = segue.destination as! SearchResultVC
            vc.modalPresentationStyle = .fullScreen
            vc.searchDoctors(SortBy: "all", keyWord: searchTv.text ?? "", userId: "75")
        }
    }
}
