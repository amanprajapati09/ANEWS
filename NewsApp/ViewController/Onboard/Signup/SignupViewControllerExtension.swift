//
//  SignupViewControllerExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/11/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit
import GooglePlacePicker

extension SignupViewController  {
    internal func validateSignUp() -> (Bool,String) {
        
        guard !txtName.textField.validateIsEmpty() else {
            return (false,"Please enter your name!")
        }
        
        guard txtPhone.textField.validatePhoneNumber() else {
            return (false,"Please enter valid phone number!")
        }
        
        guard !txtAddress.textField.validateIsEmpty() else {
            return (false,"Please enter your Address!")
        }
        
        guard txtEmail.textField.validateEmail() else {
            return (false,"Please enter your Email!")
        }
        
        guard !txtPassword.textField.validateIsEmpty() else {
            return (false,"Please enter 6 digit password!")
        }
        
        guard (txtPassword.textField.text?.characters.count)! >= 6 else {
            return (false,"Please enter 6 digit password!")
        }
        
        return (true,"")
    }
    
    internal func validateEdit() -> (Bool,String) {
        
        guard !txtName.textField.validateIsEmpty() else {
            return (false,"Please enter your name!")
        }
        
        guard txtPhone.textField.validatePhoneNumber() else {
            return (false,"Please enter valid phone number!")
        }
        
        guard !txtAddress.textField.validateIsEmpty() else {
            return (false,"Please enter your Address!")
        }
        
        return (true,"")
    }
    
    //MARK:- Textfield delegate methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard textField == txtAddress.textField else {
            return true
        }
        presentAddressPicker()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK:- Place picker delegate methods
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        txtAddress.textField.text = place.name
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        
    }
    
}
