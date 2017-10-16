//
//  ChangePasswordViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/17/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var txtCurrentPassword: RSFloatInputView!
    @IBOutlet weak var txtNewPassword: RSFloatInputView!
    @IBOutlet weak var txtReTypePassword: RSFloatInputView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnFinish: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFinishClick(_ sender: Any) {
        
    }
    
    
}
