//
//  SearchResultTableViewCell.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
import MapKit
protocol CarDetailsDelegate {
    func details(id: String , car : Car )
}
class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var CarImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.CarImage)
        }
    }
    @IBOutlet weak var addName: UILabel!
    @IBOutlet weak var addTitle: UILabel!
    @IBOutlet weak var addFees: UILabel!
    @IBOutlet weak var carAddress: UILabel!
    @IBOutlet weak var DetailsBtn: UIButton!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var likeBtn: UIButton!{
        didSet{
            likeBtn.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
    }
    var delegate: CarDetailsDelegate?
    
    var car: Car?
    
    @IBAction func addToFavoriets(_ sender: UIButton) {
        if likeBtn.currentBackgroundImage == UIImage(named: "heart") {
            likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
            
            DispatchQueue.main.async { [weak self] in
                APIClient.addFavoriteCar(user_id: UserDefault.getId(), car_id: self?.car?.id ?? "" ) { (Result) in
                    switch Result {
                    case .success(let response):
                        print(response)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
        } else {
          likeBtn.setBackgroundImage(UIImage(named: "heart"), for: .normal)
            
            DispatchQueue.main.async { [weak self] in
                APIClient.deleteFavoriteCar(user_id: UserDefault.getId(), car_id: self?.car?.id ?? "") { (Result) in
                    switch Result {
                    case .success(let response):
                        print(response)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
    @IBAction func viewOnMap(_ sender: UIButton) {
        Maps.openMaps(lat: car?.latitude ?? "0", long: car?.longitude ?? "0", distance: 10000.0 ,name: car?.name ?? "")
    

    }
    @IBAction func showDetails(_ sender: UIButton) {
        delegate?.details(id: car!.id, car:  car!)
    }
    
}
