//
//  TextFieldExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/11/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
    }
    
    func validateIsEmpty() -> Bool {
        return (self.text?.isEmpty)!
    }
    
    func validatePhoneNumber() -> Bool {
        let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return  predicate.evaluate(with: self.text!)
    }
}
