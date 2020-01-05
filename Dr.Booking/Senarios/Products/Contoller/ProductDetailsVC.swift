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
    
    //MARK: - IBOutelt
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var descreptionTitle: UILabel!
    @IBOutlet weak var descreption: UITextView!
    @IBOutlet weak var benefitsTitle: UILabel!
    @IBOutlet weak var benefits: UITextView!
    @IBOutlet weak var imageConst: NSLayoutConstraint!
    
    //MARK: - Var
    var productID = ""
    var productData: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimating()
        getDetails(with : productID)
    }
    
    //MARK: - Func getDetails Of Product
    
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
    
    //MARK: - Func updatView
    
    func updateView(){
        if let details = productData {
            productName.text = details.name
            productPrice.text = details.price
            productImage.sd_setImage(with: URL(string: details.image), placeholderImage: UIImage(named: ""))
            descreptionTitle.text = "عن المنتج"
            benefitsTitle.text = "تفاصيل"
            descreption.text = details.productDescription
            benefits.text = details.benefits
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func buyProduct(_ sender: UIButton) {
        
        APIClient.buyProduct(user_id: UserDefault.getId() , product_id: productID ) { (Result) in
            switch Result {
            case .success(let _):
                DispatchQueue.main.async {
                    Alert.show("تم الشراء", massege: "تم شراء المنتج بنجاح", context: self)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
