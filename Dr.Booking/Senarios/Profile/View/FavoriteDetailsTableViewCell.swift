//
//  FavoriteDetailsTableViewCell.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/14/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos

protocol CustomCellUpdater: class { // the name of the protocol you can put any
    func getFavoriteDoctors()
}
class FavoriteDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rateOfCar: CosmosView!
    @IBOutlet weak var CarImage: UIImageView! {
        didSet{
            Rounded.roundedImage(imageView: self.CarImage)
        }
    }
    
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carTitle: UILabel!
    @IBOutlet weak var carFees: UILabel!
    @IBOutlet weak var carAddress: UILabel!
    @IBOutlet weak var carDetailsBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!{
        didSet {
            likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
            
        }
    }
    weak var delegate: CustomCellUpdater?
    var favoriteCars:FavoriteCar?
    var car : Car?
    var delegateDetails: CarDetailsDelegate?
    
    func yourFunctionWhichDoesNotHaveASender () {
        deleteFavoriteCar()
        delegate?.getFavoriteDoctors()
    }
    
    func deleteFavoriteCar() {
        
        APIClient.deleteFavoriteCar(user_id: UserDefault.getId(), car_id: car?.id ?? ""){(Result) in
            switch Result {
            case.success(let response):
                DispatchQueue.main.async {
                    print("aaaaaaaa")
                    print(response)
                    self.favoriteCars = response
                    
                    //self.yourFunctionWhichDoesNotHaveASender()
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    print("bbbbbbbbb")
                    print(error.localizedDescription)
                }
            }
        }
        
        
    }
    
    @IBAction func addToFavoriets(_ sender: UIButton) {
        yourFunctionWhichDoesNotHaveASender()
    }
    
    @IBAction func viewOnMap(_ sender: UIButton) {
        Maps.openMaps(lat: car?.latitude ?? "0", long: car?.longitude ?? "0", distance: 10000.0 ,name: car?.name ?? "")
    }
    
    @IBAction func showDetails(_ sender: UIButton) {
        delegateDetails?.details(id: car!.id, car:  car!)
        
    }
    
}
