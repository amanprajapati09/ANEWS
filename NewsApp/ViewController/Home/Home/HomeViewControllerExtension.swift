
//
//  HomeViewControllerExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/26/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation

extension HomeViewController {
    
    //MARK:- Delegate methods
    func didSelecteItem(item: ModelBaseHome) {
        
        if item.isKind(of: ModelFlash.self) {
            performSegue(withIdentifier: Segues.kFlashDetail, sender: item)
        } else if item.isKind(of: ModelList.self) {
            performSegue(withIdentifier: Segues.kListDetail, sender: item)
        } else if item.isKind(of: ModelJob.self) {
            performSegue(withIdentifier: Segues.kJobDetail, sender: item)
        }
    }
    
    //MARK:- logout alert
    internal func askLogout() {
        let alert = UIAlertController(title: "Alert", message: "Are you sure want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { (action) in
            self.logout()
        }
        let Cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        alert.addAction(Cancel)
        alert.addAction(actionOk)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    internal func logout() {
        UIApplication.shared.keyWindow?.rootViewController = MainainStoryboard.instantiateViewController(withIdentifier: StroryBoardIdentifier.landingScreenIdentifier)
    }
}
