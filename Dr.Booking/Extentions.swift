//
//  Extentions.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 1/6/20.
//  Copyright © 2020 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit

extension UIViewController : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        return true
    }
}
