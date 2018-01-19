//
//  PostListingScreen.swift
//  NewsApp
//
//  Created by Aman Prajapati on 11/18/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import RSFloatInputView

class PostListingScreenViewController: BaseViewController {
    
    @IBOutlet weak var btnFinish: UIButton!
    
    @IBOutlet weak var txtTitle: RSFloatInputView!
    @IBOutlet weak var txtName: RSFloatInputView!
    @IBOutlet weak var txtEmail: RSFloatInputView!
    @IBOutlet weak var txtPhone: RSFloatInputView!
    @IBOutlet weak var txtDescription: RSFloatInputView!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForLanguage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnFinishClick(_ sender: Any) {
        
    }
    
    private func requestForPost () {
        
    }
    
    private func prepareForLanguage() {
        txtName.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_name")
        txtPhone.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_contact")
        txtTitle.placeHolderLabel.string = localizedShared?.localizedString(forKey: "text_title")
        txtDescription.placeHolderLabel.string = localizedShared?.localizedString(forKey: "text_description")
        txtEmail.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_email")
        btnFinish.setTitle(localizedShared?.localizedString(forKey: "button_submit"), for: .normal)
    }
}
