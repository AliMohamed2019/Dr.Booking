//
//  ProductDetailsVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class ProductDetailsVC: UIViewController, NVActivityIndicatorViewable{

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var descreptionTitle: UILabel!
    @IBOutlet weak var descreption: UITextView!
    @IBOutlet weak var benefitsTitle: UILabel!
    @IBOutlet weak var benefits: UITextView!
    
    @IBOutlet weak var imageConst: NSLayoutConstraint!
    
    var productID = ""
    var productData: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimating()
        getDetails(with : productID)
    }
    
    func getDetails(with ID : String){
        APIClient.getProductDetails(product_id: ID) { (Result) in
            switch Result {
            case .success(let Response):
                DispatchQueue.main.async {
                    self.productData = Response.product
                    self.updateView()
                    self.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.stopAnimating()
            }
        }

    }

    func updateView(){
        if let details = productData {
            productName.text = details.name
            productPrice.text = details.price
            productImage.sd_setImage(with: URL(string: details.image), placeholderImage: UIImage(named: ""))
            descreptionTitle.text = "ما هو \(details.name)"
            benefitsTitle.text = "فوائد \(details.name)"
            descreption.text = details.productDescription
            benefits.text = details.benefits
        }
    }
    
    @IBAction func buyProduct(_ sender: UIButton) {

        APIClient.buyProduct(user_id:"77" , product_id:"10" ) { (Result) in
            switch Result {
            case .success(let response):
                DispatchQueue.main.async {
                    Alert.show("تم الشراء", massege: "تم شراء المنتج بنجاح", context: self)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
