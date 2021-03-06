//
//  BaseViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var customTitleView :UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK:- Hide Navigation Bar
    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK:- Show Navigation Bar
    func showNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
    }
}
