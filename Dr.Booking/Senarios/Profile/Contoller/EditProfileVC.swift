//
//  EditProfileVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class EditProfileVC: UIViewController ,NVActivityIndicatorViewable {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var name: DesignableUITextField!
    @IBOutlet weak var phone: DesignableUITextField!
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.profileImage)
        }
    }
    
    //MARK: - Var
    
    var editProfile:EditProfile?
    let ImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        ImagePicker.delegate = self
    }
    
    //MARK: - IBAction
    
    @IBAction func editProfile(_ sender: UIButton) {
        getEditProfile()
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        ImagePicker.sourceType = .photoLibrary
        present(ImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
    }
    
    //MARK: - Func GetData Of User Login
    
    func getData() {
        profileImage.sd_setImage(with: URL(string: UserDefault.getPhoto()), placeholderImage: UIImage(named: "user"))
        name.text = UserDefault.getName()
        phone.text = UserDefault.getPhone()
        email.text = UserDefault.getEmail()
    }
    
    //MARK: - Func EditProfile
    
    func getEditProfile() {
        if let name = name.text ,let phone = phone.text , let email = email.text{
            startAnimating()
            APIClient.editProfile(user_id: UserDefault.getId(), user_name: name, user_mail: email, user_phone: phone) { (Result) in
                switch Result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.editProfile = response
                        Alert.show("", massege: self.editProfile!.message ,context: self)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        print(error.localizedDescription)
                        
                    }
                }
            }
        }
    }
    
}
//MARK: - UIImagePickerController Delegate , UINavigationControllerDelegate

extension EditProfileVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageData = info[.originalImage] as! UIImage
        profileImage.image = imageData
        _ = FirebaseUploader.uploadToFirebase(viewController: self, imagePicker: ImagePicker, didFinishPickingMediaWithInfo: info)
        
    }
}
