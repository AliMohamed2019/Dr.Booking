//
//  ProfileVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/11/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    let photsArray = ["product","profile","callender","house"]
    let namesArray = ["منتجاتي","تعديل البيانات","حجوزاتي","مفضلتي"]
    

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
        getData()
       
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getData() {
        name.text = UserDefault.getName()
        phone.text = UserDefault.getPhone()
        profileImage.sd_setImage(with: URL(string: UserDefault.getPhoto() ?? ""), placeholderImage: UIImage(named: "user"))
         
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
         
       
    }
    
    
}
