//
//  FavoriteDetailsTableViewCell.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/14/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos

protocol CustomCellUpdater: class { // the name of the protocol you can put any
    func getFavoriteDoctors()
}
class FavoriteDetailsTableViewCell: UITableViewCell {
    
       @IBOutlet weak var rateOfDoctor: CosmosView!
       @IBOutlet weak var doctorImage: UIImageView!
       @IBOutlet weak var doctorName: UILabel!
       @IBOutlet weak var DoctorTitle: UILabel!
       @IBOutlet weak var doctorFees: UILabel!
       @IBOutlet weak var doctorAddress: UILabel!
       @IBOutlet weak var DoctorDetailsBtn: UIButton!
       @IBOutlet weak var likeBtn: UIButton!{
        didSet {
            likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)

          }
       }
    
    weak var delegate: CustomCellUpdater?
    var favoriteDoctor:FavoriteDoctor?
    var favoriteDetailsViewController : FavoriteDetailsViewController?
    var doctorId : String?
    var check = 0
    
    func yourFunctionWhichDoesNotHaveASender () {
        deleteFavoriteDoctor()
        delegate?.getFavoriteDoctors()
    }
    
    
    func deleteFavoriteDoctor() {
         if let idOfDoctor = doctorId{
            print("--------------------------------------------------\(idOfDoctor)")
       APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: idOfDoctor){(Result) in
            switch Result {
            case.success(let response):
                DispatchQueue.main.async {
                    print("aaaaaaaa")
                    print(response)
                    self.favoriteDoctor = response
                    
                    //self.yourFunctionWhichDoesNotHaveASender()
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    print("bbbbbbbbb")
                    print(error.localizedDescription)
                }
        }
            }
            
        }
    }
    
      @IBAction func addToFavoriets(_ sender: UIButton) {
        yourFunctionWhichDoesNotHaveASender()
      }
    
      @IBAction func viewOnMap(_ sender: UIButton) {
      }
    
      @IBAction func showDoctorDetails(_ sender: UIButton) {
      }
    
}
