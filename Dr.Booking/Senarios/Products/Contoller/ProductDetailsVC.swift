//
//  ProductDetailsVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

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
//        getDetails(with : productID)
    }
    
//    func getDetails(with ID : String){
//        APIClient.getProductDetails(product_id: ID) { (Result) in
//            switch Result {
//            case .success(let Response):
//                DispatchQueue.main.async {
//                    self.productData = Response.product
//                    self.updateView()
//
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//    }
//
//    func updateView(){
//        if let details = productData {
//            productName.text = details.name
//            productPrice.text = details.price
//            productImage.sd_setImage(with: URL(string: details.image), placeholderImage: UIImage(named: ""))
//            descreptionTitle.text = "ما هو \(details.name)"
//            benefitsTitle.text = "فوائد \(details.name)"
//            descreption.text = details.productDescription
//            benefits.text = details.benefits
//        }
//    }
    
    @IBAction func buyProduct(_ sender: UIButton) {

//        APIClient.buyProduct(user_id: 0, product_id: 0) { (Result) in
//            switch Result {
//            case .success(let response):
//                print(response)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
}
