//
//  LoginViewControllerExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/11/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    
    internal func validateLogin() -> (Bool,String) {
        guard txtEmail.textField.validateEmail() else {
            return (false,"Enter proper email!")
        }
        
        guard !txtPassword.textField.validateIsEmpty() else {
            return (false,"Enter proper password!")
        }
        
        return (true,"")
    }
    
    
}
