//
//  ProductDetailsViewController.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/14/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class ProductDetailsViewController: UIViewController , NVActivityIndicatorViewable {
    var userProductsArray:[Product]?
    var failure:Failure?
    
    @IBOutlet weak var orderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProducts()
        
        // Do any additional setup after loading the view.
    }
    
    
    func getUserProducts() {
        self.startAnimating()
        APIClient.getUserProducts(user_id: UserDefault.getId()) { (Result) in
            switch Result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    print("aaaaaaaa")
                    print(response)
                    self.userProductsArray = response.products
                    self.orderTableView.reloadData()
                    
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.stopAnimating()
                    print("bbbbbbbbb")
                    print(error.localizedDescription)
                    APIClient.getUserProductsfailure(user_id: UserDefault.getId()) { (Result) in
                        switch Result {
                        case .success(let response):
                            DispatchQueue.main.async {
                                print("aaaaaaaa")
                                print(response)
                                self.failure = response
                                Rounded.emptyData(TabelView: self.orderTableView, View: self.view, MessageText: self.failure!.message)
                                // Alert.show("Error", massege: self.failure!.message, context: self)
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.stopAnimating()
                                print("bbbbbbbbb")
                                print(error.localizedDescription)
                            }}}
                }
            }
        }
        
    }
    
}

extension ProductDetailsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProductsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductDetailsTableViewCell
        
        cell.productName.text = userProductsArray?[indexPath.row].name ?? "منتج"
        cell.productPrice.text = userProductsArray?[indexPath.row].price ?? "١٠٠"
        cell.productImage.sd_setImage(with: URL(string: userProductsArray?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "user"))
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "ProductDetails") as! ProductDetailsVC
        vc.productID = userProductsArray?[indexPath.row].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
