//
//  PostJobViewCotrollerExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 11/3/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import GooglePlacePicker

extension PostJobViewController {
    func validateTextfielr() -> (Bool, String) {
        
        guard !txtFirmName.textField.validateIsEmpty() else {
            return (false, "Enter propre firm name.")
        }
        guard !txtJobTitle.textField.validateIsEmpty() else {
            return (false, "Enter propre job title.")
        }
        guard !txtSalary.textField.validateIsEmpty() else {
            return (false, "Enter propre salary.")
        }
        guard !txtNumberOfPosition.textField.validateIsEmpty() else {
            return (false, "Enter propre Number of position.")
        }
        guard txtEmail.textField.validateEmail() else {
            return (false, "Enter propre email.")
        }
        guard !txtContactNUmber.textField.validateIsEmpty() else {
            return (false, "Enter propre phone number.")
        }
        guard !txtAlterContactNumber.textField.validateIsEmpty() else {
            return (false, "Enter propre alternate phone number")
        }
        guard !txtContactPerson.textField.validateIsEmpty() else {
            return (false, "Enter propre contact person name")
        }
        guard !txtRecruterDesignation.textField.validateIsEmpty() else {
            return (false, "Enter propre recruter designation.")
        }
        guard !txtInterviewDate.textField.validateIsEmpty() else {
            return (false, "Enter propre recruter designation.")
        }
        guard !txtInterViewFirmAddress.textField.validateIsEmpty() else {
            return (false, "Enter propre firm address")
        }
        guard !txtJobLocation.textField.validateIsEmpty() else {
            return (false, "Enter propre job location.")
        }
        guard !txtJobDescription.textField.validateIsEmpty() else {
            return (false, "Enter propre job description.")
        }     
        guard selectedCategory != nil else {
            return (false, "Selecte category.")
        }
        guard selectedRegion != nil else {
            return (false, "Selecte region.")
        }
        
        return (true, "Success")
    }
    
    //MARK:- Textfield delegate methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == txtJobLocation.textField || textField == txtInterViewFirmAddress.textField)  {
            selectedTextfield = textField
            presentAddressPicker()
            return false
        }
        
        return true
    }
    
    //MARK:- Place picker delegate methods
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        selectedTextfield.text = place.name
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK:- Date picker methods 
    internal func createDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(didSelectDate(picker:)), for: .valueChanged)
        txtInterviewDate.textField.inputView = datePicker
    }
    
    func didSelectDate(picker:UIDatePicker)  {
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = "dd-MM-yyyy"
        
        txtInterviewDate.textField.text = dateFormator.string(from: picker.date)
    }
}
