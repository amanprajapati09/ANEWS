//
//  ListDetailViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/26/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import GooglePlacePicker

class ListDetailViewController: BaseViewController,UITextFieldDelegate, GMSPlacePickerViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    
    var modelList = ModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        addGesture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func prepareView() {
        imageView.sd_setImage(with: modelList.imageUrl, placeholderImage: placeholdeImage!)
        lblTitle.text = modelList.title
        lblName.text =  modelList.fullName
        lblContactNo.text = modelList.mobileNo
        lblEmail.text = modelList.emailId
        lblAddress.text = modelList.address
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(askToSaveImage))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    func askToSaveImage()  {
        let alert = UIAlertController(title: "Warning", message: "Are you sure want to save image to photos ?", preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            CustomPhotoAlbum.sharedInstance.save(image: self.imageView.image!)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
        }
        
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- helper methods
    internal func presentAddressPicker() {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
        placePicker.popoverPresentationController?.sourceView = txtAddress
        placePicker.popoverPresentationController?.sourceRect = txtAddress.bounds
        
        // Display the place picker. This will call the delegate methods defined below when the user
        // has made a selection.
        self.present(placePicker, animated: true, completion: nil)
    }
}

extension ListDetailViewController {
    
    //MARK:- Textfield delegate methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard textField == txtAddress else {
            return true
        }
        presentAddressPicker()
        return false
    }
    
    //MARK:- Place picker delegate methods
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        txtAddress.text = place.name
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        
    }
}
