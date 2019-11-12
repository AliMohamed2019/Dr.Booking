//
//  ProductTableViewCell.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
}
