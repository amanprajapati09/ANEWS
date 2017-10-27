//
//  FlashDetailViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/26/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class FlashDetailViewController: BaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!    
    @IBOutlet weak var imageView: UIImageView!
    
    var modelFlash = ModelFlash()
    
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
        lblTitle.text = modelFlash.title!
        lblDescription.text = modelFlash.descriptionField!
        imageView.sd_setImage(with: modelFlash.imageUrl, placeholderImage: placeholdeImage!)
    }
}
