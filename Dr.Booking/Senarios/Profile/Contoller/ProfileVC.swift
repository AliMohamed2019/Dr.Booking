//
//  ProfileVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/11/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.profileImage)
            self.profileImage.layer.borderWidth = 4
            self.profileImage.layer.borderColor = #colorLiteral(red: 0.5132408738, green: 0.8211410642, blue: 0.2199990749, alpha: 1)
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var signOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
    }
    
}
extension ProfileVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
