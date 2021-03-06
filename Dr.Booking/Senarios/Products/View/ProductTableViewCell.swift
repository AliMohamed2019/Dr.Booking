//
//  ProductTableViewCell.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
protocol BuyProductDelegate {
    func showAlert()
}

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    
    var product: Product?
    var delegate: BuyProductDelegate?
    
    
    @IBAction func butButtonPressed(_ sender: UIButton) {
        DispatchQueue.global().async {
            APIClient.buyProduct(user_id: UserDefault.getId() , product_id: self.product?.id ?? "" ) { (Result) in
                switch Result {
                case .success( _):
                    print("Done")
                    self.delegate?.showAlert()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
}
