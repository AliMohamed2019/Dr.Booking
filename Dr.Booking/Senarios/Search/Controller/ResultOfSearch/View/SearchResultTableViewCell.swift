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
protocol DectorDetailsDelegate {
    func details(id: String  )
}
class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.doctorImage)
        }
    }
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var DoctorTitle: UILabel!
    @IBOutlet weak var doctorFees: UILabel!
    @IBOutlet weak var doctorAddress: UILabel!
    @IBOutlet weak var DoctorDetailsBtn: UIButton!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var likeBtn: UIButton!
    var delegate: DectorDetailsDelegate?
    var doctorId: String?
    var lat : String?
    var long : String?
    @IBAction func addToFavoriets(_ sender: UIButton) {
        if likeBtn.image(for: .normal) == UIImage(named: "favorite1") {
            deleteDectorFromFavorites()
        } else if likeBtn.image(for: .normal) == UIImage(named: "favorite2") {
            addDectorToFavorite()
        }
    }
    
    func deleteDectorFromFavorites(){
        APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self.doctorId ?? "") { (Result) in
              switch Result {
              case .success(let response):
                  print(response)
                  self.likeBtn.setImage(UIImage(named: "favorite2"), for: .normal)
              case .failure(let error):
                  print(error)
              }
          }
      }
      
      func addDectorToFavorite(){
        APIClient.addFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self.doctorId ?? "" ) { (Result) in
              switch Result {
              case .success(let response):
                  print(response)
                  self.likeBtn.setImage(UIImage(named: "favorite1"), for: .normal)
              case .failure(let error):
                  print(error)
              }
          }
      }
    
    
    
    
    @IBAction func viewOnMap(_ sender: UIButton) {
        Maps.openMaps(lat: lat ?? "0", long: long ?? "0", distance: 10000.0 ,name: doctorName.text ?? "")
    

    }
    @IBAction func showDoctorDetails(_ sender: UIButton) {
        delegate?.details(id: self.doctorId ?? "" )
    }
    
}
