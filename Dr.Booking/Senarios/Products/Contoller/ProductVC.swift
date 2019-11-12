//
//  ProductVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/11/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

 
}
extension ProductVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    
}
