//
//  ProfileVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/11/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.profileImage)
            
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var signOutBtn: UIButton!
    
    //MARK: - Var
    
    let photsArray = ["product","profile","callender","house"]
    let namesArray = ["منتجاتي","تعديل البيانات","حجوزاتي","مفضلتي"]
    let viewControllerArray = ["ProductDetailsViewController","EditProfileVC" , "ReservationsViewController" , "FavoriteDetailsViewController"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
    }
    
    //MARK: - IBAction
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        UserDefault.setcheckLogin(false)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Func GetData Of User Login
    
    func getData() {
        name.text = UserDefault.getName()
        phone.text = UserDefault.getPhone()
        profileImage.sd_setImage(with: URL(string: UserDefault.getPhoto()), placeholderImage: UIImage(named: "user"))
        TableView.reloadData()
        
    }
    
   
}

//MARK: - TableView DataSource Methods

extension ProfileVC: UITableViewDelegate , UITableViewDataSource {
    
    //TODO: Declare numberOfRowsInSection here:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photsArray.count
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProfileTableViewCell
        cell.iconImage.image = UIImage(named: photsArray[indexPath.row])
        cell.title.text = namesArray[indexPath.row]
        return cell
        
    }
    //TODO: Declare didSelectRowAt here:
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier:  viewControllerArray[indexPath.row]) 
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
