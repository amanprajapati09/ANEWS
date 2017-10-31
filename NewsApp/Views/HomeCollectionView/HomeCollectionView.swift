//
//  HomeCollectionView.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/22/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

protocol ItemSelection {
    func didSelecteItem(item:ModelBaseHome)
    func didSelectHeaderItem(headerValue:headerEnum)
}

class HomeCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ItemSelection {

   @IBOutlet weak var homeCollectionView: UICollectionView!
    var delegate:ItemSelection?
    
    var selectedCategory:Category? {
        didSet {
            homeCollectionView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        registerCell()        
    }
    
    //MARK:- Collectionview datasource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashCollectionViewCell.reuseIdentifier, for: indexPath) as! FlashCollectionViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingCollectionViewCell.reuseIdentifier, for: indexPath) as! ListingCollectionViewCell
            cell.selectedCategory = selectedCategory
            cell.delegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BulletineCollectionViewCell.reuseIdentifier, for: indexPath) as! BulletineCollectionViewCell
            cell.selectedCategory = selectedCategory
            cell.delegate = self
            return cell
        
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobCollectionViewCell.reuseIdentifier, for: indexPath) as! JobCollectionViewCell
            cell.selectedCategory = selectedCategory
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.reuseIdentifier, for: indexPath) as! MediaCollectionViewCell
            cell.selectegCategory = selectedCategory
            cell.delegate = self
            return cell
        default :
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashCollectionViewCell.reuseIdentifier, for: indexPath) as! FlashCollectionViewCell
            return cell
        }
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

    //MARK:- Delegate Methods
    func didSelecteItem(item: ModelBaseHome) {
        delegate?.didSelecteItem(item: item)
    }
    
    func didSelectHeaderItem(headerValue: headerEnum) {
        delegate?.didSelectHeaderItem(headerValue: headerValue)
    }

}
