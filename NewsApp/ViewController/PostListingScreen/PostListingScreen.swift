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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnFinishClick(_ sender: Any) {
        
    }
    
    private func requestForPost () {
        
    }
    
}
