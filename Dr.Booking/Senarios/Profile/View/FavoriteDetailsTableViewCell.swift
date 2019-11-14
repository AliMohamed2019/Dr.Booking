//
//  FavoriteDetailsTableViewCell.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/14/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos

class FavoriteDetailsTableViewCell: UITableViewCell {
       @IBOutlet weak var doctorImage: UIImageView!
       @IBOutlet weak var doctorName: UILabel!
       @IBOutlet weak var DoctorTitle: UILabel!
       @IBOutlet weak var doctorFees: UILabel!
       @IBOutlet weak var doctorAddress: UILabel!
       @IBOutlet weak var DoctorDetailsBtn: UIButton!
       @IBOutlet weak var likeBtn: UIButton!
       var doctorId : String?
        var check = 0
    @IBOutlet weak var rateOfDoctor: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    
    func deleteFavoriteDoctor() {
         if let idOfDoctor = doctorId{
       APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: idOfDoctor){(Result) in
            switch Result {
            case.success(let response):
                DispatchQueue.main.async {
                    print("aaaaaaaa")
                    print(response)
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
        
        deleteFavoriteDoctor()
        check = 1
       
      }
      @IBAction func viewOnMap(_ sender: UIButton) {
      }
      @IBAction func showDoctorDetails(_ sender: UIButton) {
      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
