//
//  Rate.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
class Rate: UIViewController {
    
    
    @IBOutlet weak var rateView2: UIView!{
        didSet{
            self.rateView2.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var rateView: UIView!{
        didSet{
            self.rateView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var rateStars: CosmosView!
    
    var doctorID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
    }
    
    override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1609589041)
    }
    
    //TODO: Set the tapGesture here:
    func addTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        view.addGestureRecognizer(tapGesture)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: nil)
        rateView.addGestureRecognizer(tapGesture2)
    }
    
    @objc func tableViewTapped()  {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateButtonPressed(_ sender: UIButton) {
        
        APIClient.rateDoctor(user_id: UserDefault.getId(), doctor_id: doctorID, rate: rateStars.rating) { (Result) in
            switch Result {
            case .success(let response):
                print(response)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}
