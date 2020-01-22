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
    func details(id: String , doctor : Doctor )
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
    @IBOutlet weak var likeBtn: UIButton!{
        didSet{
            likeBtn.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
    }
    var delegate: DectorDetailsDelegate?
    var doctor: Doctor?
    @IBAction func addToFavoriets(_ sender: UIButton) {
        if likeBtn.currentBackgroundImage == UIImage(named: "heart") {
            likeBtn.setBackgroundImage(UIImage(named: "like"), for: .normal)
            
            DispatchQueue.main.async { [weak self] in
                APIClient.addFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self?.doctor?.id ?? "" ) { (Result) in
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
                APIClient.deleteFavoriteDoctor(user_id: UserDefault.getId(), doctor_id: self?.doctor?.id ?? "") { (Result) in
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
        Maps.openMaps(lat: doctor?.latitude ?? "0", long: doctor?.longitude ?? "0", distance: 10000.0 ,name: doctor?.name ?? "")
    

    }
    @IBAction func showDoctorDetails(_ sender: UIButton) {
        delegate?.details(id: doctor!.id, doctor:  doctor!)
    }
    
}
