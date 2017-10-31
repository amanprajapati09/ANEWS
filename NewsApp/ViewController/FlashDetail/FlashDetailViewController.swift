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
        addGesture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func prepareView() {
        lblTitle.text = modelFlash.title
        lblDescription.text = modelFlash.descriptionField!
        imageView.sd_setImage(with: modelFlash.imageUrl, placeholderImage: placeholdeImage!)
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
}
