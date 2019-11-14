//
//  EditProfileVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    var editProfile:EditProfile?

    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.profileImage)
        }
    }
    
    @IBOutlet weak var name: DesignableUITextField!
    @IBOutlet weak var phone: DesignableUITextField!
    @IBOutlet weak var email: DesignableUITextField!
    
    
    let ImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        ImagePicker.delegate = self

    }
    
    @IBAction func editProfile(_ sender: UIButton) {
        getEditProfile()
        
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        ImagePicker.sourceType = .photoLibrary
        present(ImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
    }
    
    
    func getData() {
        name.text = UserDefault.getName()
        phone.text = UserDefault.getPhone()
        email.text = UserDefault.getEmail()
    }
    
    
    func getEditProfile() {
        if let name = name.text ,let phone = phone.text , let email = email.text{
            APIClient.editProfile(user_id: UserDefault.getId(), user_name: name, user_mail: email, user_phone: phone) { (Result) in
                switch Result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print("aaaaaaaa")
                        print(response)
                        self.editProfile = response
                        Alert.show("Error", massege: self.editProfile!.message ,context: self)
                   }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("bbbbbbbbb")
                        print(error.localizedDescription)
                       
                    }
                }
                }
            }
    }
    
}
extension EditProfileVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageData = info[.originalImage] as! UIImage
        profileImage.image = imageData
        UserDefault.setPhoto(info[.originalImage] as! String)
       
        
    }
}
