//
//  ListDetailViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/26/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class ListDetailViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var modelList = ModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func prepareView() {
        imageView.sd_setImage(with: modelList.imageUrl, placeholderImage: placeholdeImage!)
        lblTitle.text = modelList.title!
        lblName.text =  modelList.fullName!
        lblContactNo.text = modelList.mobileNo
        lblEmail.text = modelList.emailId!
        lblAddress.text = modelList.address!
    }
}
