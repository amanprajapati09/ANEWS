//
//  HomeCollectionView.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/22/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class HomeCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

   @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        registerCell()
        
    }
    
    //MARK:- Collectionview datasource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell!
        switch indexPath.row {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashCollectionViewCell.reuseIdentifier, for: indexPath) as! FlashCollectionViewCell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingCollectionViewCell.reuseIdentifier, for: indexPath) as! ListingCollectionViewCell
            
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: BulletineCollectionViewCell.reuseIdentifier, for: indexPath) as! BulletineCollectionViewCell
        
        case 3:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobCollectionViewCell.reuseIdentifier, for: indexPath) as! JobCollectionViewCell
        case 4:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.reuseIdentifier, for: indexPath) as! MediaCollectionViewCell
        default :
          cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashCollectionViewCell.reuseIdentifier, for: indexPath) as! FlashCollectionViewCell
        }
        
        return cell
    }
    
    //MARK:- Collectionview delegate methods 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    private func registerCell() {
        homeCollectionView.register(FlashCollectionViewCell.self)
        homeCollectionView.register(ListingCollectionViewCell.self)
        homeCollectionView.register(BulletineCollectionViewCell.self)
        homeCollectionView.register(JobCollectionViewCell.self)
        homeCollectionView.register(MediaCollectionViewCell.self)
    }
}
