//
//  SearchResultTableViewCell.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.doctorImage)
        }
    }
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var DoctorTitle: UILabel!
    @IBOutlet weak var doctorFees: UILabel!
    @IBOutlet weak var doctorAddress: UILabel!
    @IBOutlet weak var DoctorDetailsBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var rateView: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func addToFavoriets(_ sender: UIButton) {
    }
    @IBAction func viewOnMap(_ sender: UIButton) {
    }
    @IBAction func showDoctorDetails(_ sender: UIButton) {
    }
    
}
