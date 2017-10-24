//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/16/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import FTPopOverMenu_Swift


class HomeViewController: BaseViewController {

    @IBOutlet weak var navigationBar: NavigationBar!    
    @IBOutlet weak var segmentView: STVSegmentButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItemClick()
        segmentViewDelegateMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentView.buttonArray = ["FLASH","LISTING","BULLETING","JOB-HIRE","MEDIA"]
    }

    private func navigationItemClick() {
        navigationBar.rightItemClick = {
            let barButtonItem = self.navigationItem.rightBarButtonItem!
            let buttonItemView = barButtonItem.value(forKey: "view") as? UIView
            let buttonItemSize = buttonItemView?.frame
            self.presentPopover(senderFrame:buttonItemSize!)
        }
    }
    
    //MARK:- Methods to create menu option
    private func presentPopover(senderFrame:CGRect) {
       
        let configuration = FTConfiguration.shared
        configuration.backgoundTintColor = .white
        configuration.textColor = .gray
        configuration.menuWidth = 160
        FTPopOverMenu.showFromSenderFrame(senderFrame:senderFrame,
                                          with: ["Change Language","Change Password", "Logout"],
                                          done: { (selectedIndex) -> () in
            self.popoverButtonClick(index: selectedIndex)
        }) {
            
        }
    }
    
    private func popoverButtonClick(index:Int) {
        switch index {
        case 0:
            break
        case 1:
            performSegue(withIdentifier: Segues.kToChangePasswordFromHome, sender: nil)
            break
        case 2:
            break
        default:
            break
        }
    }
    
    private func segmentViewDelegateMethod() {
        segmentView.segmentButtonSelectAtIndex { (index) in
            
        }
    }
    
}
