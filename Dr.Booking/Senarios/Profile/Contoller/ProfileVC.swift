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
            
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var signOutBtn: UIButton!
    
   let photsArray = ["product","profile","callender","house"]
   let namesArray = ["منتجاتي","تعديل البيانات","حجوزاتي","مفضلتي"]
   let viewControllerArray = ["GoToProductDetails","GoToProfileDetails" , "GoToReservationDetails" , "GoToFavoriteDetails "]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getData() {
        name.text = UserDefault.getName()
        phone.text = UserDefault.getPhone()
        profileImage.sd_setImage(with: URL(string: UserDefault.getPhoto()), placeholderImage: UIImage(named: "user"))
        TableView.reloadData()
        
    }
}


extension ProfileVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProfileTableViewCell
        cell.iconImage.image = UIImage(named: photsArray[indexPath.row])
        cell.title.text = namesArray[indexPath.row]
       return cell
               
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: viewControllerArray[indexPath.row], sender: self)
    }
    
}
