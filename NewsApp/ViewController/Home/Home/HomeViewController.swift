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

class HomeViewController: BaseViewController, ItemSelection, SFSafariViewControllerDelegate, CategorySelectionDelegate,UISearchBarDelegate {
    
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
    
    @IBOutlet weak var horizontalSpaceBetweenRegion_Category: NSLayoutConstraint!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    
    var selectedMode = headerEnum.eFlash
    var isRegion:Bool = false //Use for message title in category selection view
    
    var searchBar = UISearchBar()
    var searchBarButtonItem: UIBarButtonItem?
    
    var selectedFilter = FilterContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestForCategory()
        navigationItemClick()
        segmentViewDelegateMethod()
        homeCollectionViewDelegateMethod()
        homeCollectionContainer.delegate = self
        
        
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.showsCancelButton = true
        searchBarButtonItem = navigationItem.rightBarButtonItem
        
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
        navigationBar.rightSearchItemClick = {
            self.showSearchBar()
        }
        
        navigationBar.rightProfileItemClick = {
            
            if userDefault.value(forKey: MyUserDefault.USER_ID) == nil {
                self.presentLoginView()
            } else {
                self.performSegue(withIdentifier: Segues.kToEditProfile, sender: nil)
            }
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
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2), execute: {
                self.presentLoginView()
            })
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
        
        var menuArray:[String]!
        
        if userDefault.value(forKey: MyUserDefault.USER_ID) == nil {
            menuArray = ["Change Language"]
        } else {
            menuArray = ["Change Language","Change Password", "Logout"]
        }
        
        FTPopOverMenu.showFromSenderFrame(senderFrame:senderFrame,
                                          with: menuArray,
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
            
            if index == 1 {
                self.navigationBar.showSearchBar()
            } else {
                self.navigationBar.hideSearchBar()
                self.hideSearchBar()
            }
            
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
            destinationViewController.titleLabel = createcategoryPickerTitleMessage()
            destinationViewController.delegate = self
            destinationViewController.categoryList = sender as! [Category]
        } else if segue.identifier == Segues.kToEditProfile {
            let destinationViewController = segue.destination as! SignupViewController
            destinationViewController.isForEditProfile = true
        }
    }
    
    private func createcategoryPickerTitleMessage() -> String {
        if isRegion {
            return "Select region for \(selectedMode.rawValue)"
        } else {
            return "Select category for \(selectedMode.rawValue)"
        }
    }
    
    //MARK:- Extra methods
    func showSearchBar() {
        searchBar.alpha = 0
        navigationItem.titleView = searchBar
        navigationItem.setLeftBarButton(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func hideSearchBar() {
        //navigationItem.setLeftBarButton(searchBarButtonItem, animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
    }
    
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
        selectedFilter.searchText = ""
        homeCollectionContainer.selectedFilter = selectedFilter
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        selectedFilter.searchText = searchBar.text!
        homeCollectionContainer.selectedFilter = selectedFilter
    }
}
