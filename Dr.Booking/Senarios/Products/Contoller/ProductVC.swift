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
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var TableView: UITableView!
    
    //MARK: - Var
    var productsArray:[Product]?
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.rowHeight = 140
        getProductsData()
        
    }
    //MARK: - Func getProduct of User
    
    func getProductsData(){
        DispatchQueue.global().async {
            APIClient.getAllProduct { (Result) in
                switch Result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.productsArray = response.products
                        print(self.productsArray)
                        self.TableView.reloadData()
                        Rounded.emptyData(TabelView: self.TableView, View: self.view, MessageText: "لا توجد أدوية متاحة")
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}

//MARK: - TableView DataSource Methods
extension ProductVC : UITableViewDelegate , UITableViewDataSource {
    
    //TODO: Declare numberOfRowsInSection here:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productsArray?.count ?? 0
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductTableViewCell
        
        cell.productName.text = productsArray?[indexPath.row].name ?? "منتج"
        cell.productPrice.text = productsArray?[indexPath.row].price ?? "١٠٠"
        cell.productImage.sd_setImage(with: URL(string: productsArray?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "user"))
        cell.product = productsArray?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TODO: Declare didSelectRowAt here:
        
        let vc = storyboard?.instantiateViewController(identifier: "ProductDetails") as! ProductDetailsVC
        vc.productID = productsArray?[indexPath.row].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



extension ProductVC: BuyProductDelegate {
    func showAlert() {
        Alert.show("تم الشراء", massege: "تم شراء المنتج بنجاح", context: self)
    }
    
    
}
