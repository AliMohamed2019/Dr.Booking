//
//  ProductVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/11/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import SDWebImage
class ProductVC: UIViewController {

    
    @IBOutlet weak var TableView: UITableView!
    
    var productsArray:[Product]?
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.rowHeight = 140
        
        getProductsData()
    }
    
    func getProductsData(){
        DispatchQueue.global().async {
            APIClient.getAllProduct { (Result) in
                switch Result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.productsArray = response.products
                        print(self.productsArray)
                        self.TableView.reloadData()
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

 
}

extension ProductVC : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return productsArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductTableViewCell

        cell.productName.text = productsArray?[indexPath.row].name ?? "منتج"
        cell.productPrice.text = productsArray?[indexPath.row].price ?? "١٠٠"
        cell.productImage.sd_setImage(with: URL(string: productsArray?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "user"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "ProductDetails") as! ProductDetailsVC
         vc.productID = productsArray?[indexPath.row].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
   
    
    
}
