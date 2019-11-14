//
//  UserDefault.swift
//  Dr.Booking
//
//  Created by Mustafa on 11/13/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import Foundation

struct UserDefault {
    static let id =  "id"
    static let name = "name"
    static let email = "email"
    static let phone = "phone"
    static let photo = "photo"
    
    
    
    static func setId ( _ id : String){
        UserDefaults.standard.set(id, forKey: self.id)
    }
    static func getId () ->String{
        return UserDefaults.standard.string(forKey: self.id) ??  ""
    }
    
    static func setName ( _ name : String){
        UserDefaults.standard.set(name, forKey: self.name)
    }
    static func getName () ->String{
        return UserDefaults.standard.string(forKey: self.name) ??  ""
    }
    
    static func setEmail ( _ email : String){
        UserDefaults.standard.set(email, forKey: self.email)
    }
    static func getEmail () ->String{
        return UserDefaults.standard.string(forKey: self.email) ??  ""
    }
    
    static func setPhone ( _ phone : String){
        UserDefaults.standard.set(phone, forKey: self.phone)
    }
    static func getPhone () ->String{
        return UserDefaults.standard.string(forKey: self.phone) ??  ""
    }
    static func setPhoto ( _ photo : String){
        UserDefaults.standard.set(photo, forKey: self.photo)
    }
    static func getPhoto () ->String{
        return UserDefaults.standard.string(forKey: self.photo) ??  ""
    }
}
