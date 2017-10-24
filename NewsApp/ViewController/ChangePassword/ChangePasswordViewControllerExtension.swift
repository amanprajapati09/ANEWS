//
//  ChangePasswordViewControllerExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/21/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit

extension ChangePasswordViewController {
    
    
    internal func validateChangePassword()-> (Bool,String) {
        
        guard !txtCurrentPassword.textField.validateIsEmpty() else {
            return (false,"Enter current password!")
        }
        
        guard !txtNewPassword.textField.validateIsEmpty() else {
            return (false,"Enter new password!")
        }
        
        guard !txtReTypePassword.textField.validateIsEmpty() else {
            return (false,"Retype new password!")
        }

        guard txtReTypePassword.textField.text == txtNewPassword.textField.text else {
            return (false,"Miss match retype password!")
        }

        
        return (true,"")
    }

}
