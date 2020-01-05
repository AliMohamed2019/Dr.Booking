//
//  ReservationDetailsTableViewCell.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/17/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos

protocol DectorsDetailsProtcolDelegate {
    func details(id: String )
}
class ReservationDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.carImage)
        }
    }
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var rateOfAdd: CosmosView!
    @IBOutlet weak var carTitle: UILabel!
    @IBOutlet weak var carFees: UILabel!
    @IBOutlet weak var carAddress: UILabel!
    @IBOutlet weak var carDate: UILabel!
    
    var location: Reservation?
    var delegate: DectorsDetailsProtcolDelegate?
    var carId : String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func goToMap(_ sender: UIButton) {
        Maps.openMaps(lat: location?.latitude ?? "0", long: location?.longitude ?? "0", distance:  10000 , name: location?.car ?? "")
    }
    @IBAction func showDoctorDetails(_ sender: UIButton) {
        delegate?.details(id: carId!)
    }
}
