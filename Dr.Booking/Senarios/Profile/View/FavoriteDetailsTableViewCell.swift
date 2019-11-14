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
    
    @IBOutlet weak var rateOfDoctor: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func addToFavoriets(_ sender: UIButton) {
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
