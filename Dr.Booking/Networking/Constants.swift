//
//  Constants.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 26/11/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        
        static let baseURL = "http://drbookingsa.com/renova_en"
        static let webserviceUser = "54732964"
        static let webservicePass = "259743"
        static let userType = "User"
        static let productType = "product"
        static let DoctorType = "Doctor"
    }
    
    //login
    struct login {
        static let mail = "mail"
        static let password = "password"
    }
    
    //register
    struct register {
          static let user_name = "user_name"
          static let mail = "mail"
          static let phone = "phone"
          static let pass = "pass"
      }
    
    //add doctor to favorite
    struct addFavoriteDoctor  {
          static let user_id = "user_id"
          static let doctor_id = "doctor_id"
             
         }
    
    //delete doctor from favorites
      struct deleteFavoriteDoctor  {
        static let user_id = "user_id"
        static let doctor_id = "doctor_id"
           
       }
    
    //get user favorite Offers
    struct getFavoriteDoctors  {
         static let user_id = "user_id"
                     
        }
    
    //rate doctor
    struct addRate  {
         static let user_id = "user_id"
         static let doctor_id = "doctor_id"
         static let rate = "rate"
                     
        }
    
   
    
    //view product details
    struct viewProduct  {
         static let product_id = "product_id"
                     
        }
    
    //user order product (make order)
    struct buyProduct  {
         static let user_id = "user_id"
         static let product_id = "product_id"
                     
        }
    
    //user orders (show orders)
    struct getUserProducts  {
         static let user_id = "user_id"
                     
        }
    
    //edit user profile
    struct editProfile  {
     static let user_id = "user_id"
     static let user_name = "user_name"
     static let user_mail = "user_mail"
     static let user_phone = "user_phone"
                 
    }
    
    //Search
    struct Search  {
     static let search_words = "search_words"
     static let order_by = "order_by"
     static let user_id = "user_id"
                 
    }
    
    //view doctor information and reservation dates
    struct viewDoctor  {
     static let user_id = "user_id"
     static let doctor_id = "doctor_id"

    }
    
    // make reservation
    struct make_reservation  {
     static let user_id = "user_id"
     static let doctor_id = "doctor_id"
     static let docotor_reservation_date_id = "docotor_reservation_date_id"
        
    }
    //view user reservations
    struct view_reservations  {
     static let user_id = "user_id"
                 
    }
    
    //view All Doctors
    struct getAllDoctors  {
     static let user_id = "user_id"
                 
    }
    
    //view user Profile
    struct viewProfile  {
     static let user_id = "user_id"
                 
    }
    
    //forget password
    struct forget_pass  {
     static let user_email = "user_email"
                 
    }
    
    //change password
    struct update_password  {
     static let user_id = "user_id"
     static let Current_Password = "Current_Password"
     static let New_Password = "New_Password"
     static let ReType_New_Password = "ReType_New_Password"
                 
    }

    
    
    
    
    
}



enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
