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
    
    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
                  Rounded.roundedImage(imageView: self.doctorImage)
              }
    }
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var rateOfDoctor: CosmosView!
    @IBOutlet weak var DoctorTitle: UILabel!
    @IBOutlet weak var doctorFees: UILabel!
    @IBOutlet weak var doctorAddress: UILabel!
    @IBOutlet weak var doctorDate: UILabel!
    
    var location: Reservation?
    var delegate: DectorsDetailsProtcolDelegate?
    var doctorId : String?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func goToMap(_ sender: UIButton) {
        Maps.openMaps(lat: location?.latitude ?? "0", long: location?.longitude ?? "0", distance:  10000 , name: location?.doctor ?? "")
    }
    @IBAction func showDoctorDetails(_ sender: UIButton) {
        delegate?.details(id: doctorId!)
       }
}
