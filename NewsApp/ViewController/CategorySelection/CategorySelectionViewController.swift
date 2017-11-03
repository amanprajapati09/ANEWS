//
//  CategorySelectionViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/31/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

protocol CategorySelectionDelegate {
    func didSelectCagtegory(seletedCategory:Category)
}

class CategorySelectionViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    
    var categoryList = [Category]()
    var filterList = [Category]() {
        didSet {
            tblView.reloadData()
        }
    }
    
    var delegate:CategorySelectionDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterList = categoryList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- IBActions
    @IBAction func textFieldValueChange(_ sender: UITextField) {
        guard sender.text?.characters.count == 0 else {
            filterList = categoryList.filter({ (object) -> Bool in
                return (object.name?.lowercased().contains(sender.text!))!
            })
            return
        }
        
        filterList = categoryList
    }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //MARK:- Tableview Datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "identifier")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
        }
        cell?.textLabel?.text = filterList[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        delegate?.didSelectCagtegory(seletedCategory: filterList[indexPath.row])
    }
    
}
