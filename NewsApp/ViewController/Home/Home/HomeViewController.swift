//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/16/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import FTPopOverMenu_Swift
import SafariServices

class HomeViewController: BaseViewController, ItemSelection, SFSafariViewControllerDelegate, CategorySelectionDelegate {

    @IBOutlet weak var navigationBar: NavigationBar!    
    @IBOutlet weak var segmentView: STVSegmentButtonView!
    @IBOutlet weak var homeCollectionContainer: HomeCollectionView!
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var btnGetAJob: UIButton!
    @IBOutlet weak var btnPostAJob: UIButton!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var regionWidthConstraint: NSLayoutConstraint!
    @IBOutlet var categoryRegionEqualConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    
    var selectedMode = headerEnum.eFlash
    var isRegion:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestForCategory()
        navigationItemClick()
        segmentViewDelegateMethod()
        homeCollectionViewDelegateMethod() 
        homeCollectionContainer.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentView.buttonArray = ["FLASH","LISTING","BULLETIN","JOB-HIRE","MEDIA"]
    }

    private func navigationItemClick() {
        navigationBar.rightItemClick = {
            let barButtonItem = self.navigationItem.rightBarButtonItem!
            let buttonItemView = barButtonItem.value(forKey: "view") as? UIView
            let buttonItemSize = buttonItemView?.frame
            self.presentPopover(senderFrame:buttonItemSize!)
        }
    }
    
    //MARK:- Action Methods
    
    @IBAction func categoryButtonClickAction(_ sender: Any) {
        isRegion = false
        didSelectHeaderItem()
    }
    
    @IBAction func regionButtonClickAction(_ sender: Any) {
        isRegion = true
        didSelectHeaderItem()
    }
    
    @IBAction func GetAJobButtonClickAction(_ sender: Any) {
    }
    
    @IBAction func PostAJobButtonClickAction(_ sender: Any) {
        
//        userDefault.setValue(model.id, forKey: MyUserDefault.USER_ID)
        guard (userDefault.value(forKey: MyUserDefault.USER_ID) != nil) else {
            showNotificationAlert(type: .error, title: "Warning!", message: "Please login  first to post job")
            return 
        }
        performSegue(withIdentifier: Segues.postjobView, sender: nil)
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
            askLogout()
            break
        default:
            break
        }
    }
    
    private func segmentViewDelegateMethod() {
        
        segmentView.segmentButtonSelectAtIndex { (index) in
           
            self.resetCategoryandregion()
            self.UIChangesAsPerIndexSelection(index: index)
            self.homeCollectionContainer.selectedCategory = nil
            self.homeCollectionContainer.homeCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }

    private func homeCollectionViewDelegateMethod() {
        homeCollectionContainer.scrollingAtIndex = { (index) in
            
            self.resetCategoryandregion()
            self.UIChangesAsPerIndexSelection(index: index)
            self.segmentView.buttonCollectionView?.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
            self.segmentView.selectedIndex = index 
            self.segmentView.buttonCollectionView?.reloadData()
            self.segmentView.buttonCollectionView?.collectionViewLayout.invalidateLayout()
        }
    }
    
    //MARK:- Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segues.kFlashDetail {
            let destinationViewController = segue.destination as! FlashDetailViewController
            destinationViewController.modelFlash = sender as! ModelFlash
        } else if segue.identifier == Segues.kListDetail {
            let destinationViewController = segue.destination as! ListDetailViewController
            destinationViewController.modelList = sender as! ModelList
        } else if segue.identifier == Segues.kJobDetail {
            let destinationViewController = segue.destination as! JobDetailViewController
            destinationViewController.modelJob = sender as! ModelJob
        } else if segue.identifier == Segues.categoryView {
            
            let destinationViewController = segue.destination as! CategorySelectionViewController
            
            destinationViewController.delegate = self
            destinationViewController.categoryList = sender as! [Category]
        }
    }

    //MARK:- Helper Method
    func UIChangesAsPerIndexSelection(index:Int) {
        switch index {
        case 0:
            self.headerViewHeightConstraint.constant = 0.0
            selectedMode = .eFlash
            break
        case 1:
            self.headerViewHeightConstraint.constant = 50.0
            self.categoryRegionBothVisible(flag: true)
            self.categoryRegionWith(color: UIColor.black)
            selectedMode = .eListing
            break
        case 2:
            self.headerViewHeightConstraint.constant = 50.0
            self.categoryRegionBothVisible(flag: false)
            self.categoryRegionWith(color: UIColor.black)
            selectedMode = .eBulletin
            break
        case 3:
            self.headerViewHeightConstraint.constant = 94.0
            self.categoryRegionBothVisible(flag: true)
            self.categoryRegionWith(color: UIColor.lightGray)
            selectedMode = .eJob
            break
        case 4:
            self.headerViewHeightConstraint.constant = 50.0
            self.categoryRegionBothVisible(flag: false)
            self.categoryRegionWith(color: UIColor.black)
            selectedMode = .eMedia
            break
        default:
            break
        }
        self.view.layoutIfNeeded()
    }
    func categoryRegionBothVisible(flag:Bool) {
        if flag {
            self.categoryRegionEqualConstraint.isActive = true
            self.regionWidthConstraint.isActive = false
            self.regionWidthConstraint.constant = 0
        }
        else {
            self.categoryRegionEqualConstraint.isActive = false
            self.regionWidthConstraint.isActive = true
            self.regionWidthConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
    }
    func categoryRegionWith(color:UIColor)
    {
        self.categoryView.backgroundColor = color
        self.regionView.backgroundColor = color
    }
}
