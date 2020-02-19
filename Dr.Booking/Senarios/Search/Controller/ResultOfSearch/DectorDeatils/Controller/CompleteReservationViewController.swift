//
//  CompleteReservationViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 2/19/20.
//  Copyright © 2020 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class CompleteReservationViewController: UIViewController {
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var popView: UIView!{
        didSet{
           popView.layer.cornerRadius = 20
           popView.clipsToBounds = true
        }
    }
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var lableMsg: UILabel!
    var msgText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        // Do any additional setup after loading the view.
    }
    
   
    func startAnimation()  {
        if let msgText = msgText {
            lableMsg.text = msgText
            print(msgText)
            self.animationView.isHidden = false
            let view = StartAnimationView.showLottie(view: self.animationView, fileName: "reservation", contentMode: .scaleAspectFit)
            view.play { (finished) in
                if finished {
                    let view = StartAnimationView.showLottie(view: self.animationView, fileName: "success", contentMode: .scaleAspectFit)
                    view.play { (finished) in
                        if finished {
                            self.animationView.isHidden = true
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            // Fallback on earlier versions
                        }
                        
                    }
                } else {
                    // Fallback on earlier versions
                }
                
            }
        }
    }
    
}
