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
    
    @IBOutlet weak var rateOfDoctor: CosmosView!
    @IBOutlet weak var doctorImage: UIImageView! {
        didSet{
            Rounded.roundedImage(imageView: self.doctorImage)
        }
    }
    
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var DoctorTitle: UILabel!
    @IBOutlet weak var doctorFees: UILabel!
    @IBOutlet weak var doctorAddress: UILabel!
    @IBOutlet weak var DoctorDetailsBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    weak var delegate: CustomCellUpdater?
    var delegateDetails: DectorDetailsDelegate?
    var doctorId: String?
    var lat : String?
    var long : String?
    func yourFunctionWhichDoesNotHaveASender () {
        deleteDectorFromFavorites()
        delegate?.getFavoriteDoctors()
    }
    
    
    
    
    func deleteDectorFromFavorites(){
      APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self.doctorId ?? "") { (Result) in
            switch Result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func addToFavoriets(_ sender: UIButton) {
        yourFunctionWhichDoesNotHaveASender()
    }
    
    @IBAction func viewOnMap(_ sender: UIButton) {
        Maps.openMaps(lat: lat ?? "0", long: long ?? "0", distance: 10000.0 ,name: doctorName.text ?? "")
    }
    
    @IBAction func showDoctorDetails(_ sender: UIButton) {
        delegateDetails?.details(id: doctorId!)
        
    }
    
}
