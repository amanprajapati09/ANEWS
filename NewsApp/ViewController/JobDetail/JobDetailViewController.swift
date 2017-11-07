//
//  JobDetailViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/27/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import MessageUI

class JobDetailViewController: BaseViewController, UITableViewDataSource, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tblView: UITableView!
    var modelJob: ModelJob!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(JobDetailTableViewCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: JobDetailTableViewCell.reuseIdentifier) as! JobDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.lblTitle.text = "JOB TITLE"
            cell.lblvalue.text = modelJob.jobTitle
            break;
        case 1:
            cell.lblTitle.text = "HIRING FIRM NAME"
            cell.lblvalue.text = modelJob.firmName
            break;
        
        case 2:
            cell.lblTitle.text = "SALARY"
            cell.lblvalue.text = modelJob.salary
            break;
        
        case 3:
            cell.lblTitle.text = "NO OF POST"
            cell.lblvalue.text = modelJob.noOfPost
            break;
        
        case 4:
            cell.lblTitle.text = "EMAIL ID"
            cell.lblvalue.text = modelJob.emailId
            break;
        
        case 5:
            cell.lblTitle.text = "CONTACT NUMBER 1"
            cell.lblvalue.text = modelJob.contactNo
            break;
        
        case 6:
            cell.lblTitle.text = "CONTACT NUMBER 1"
            cell.lblvalue.text = modelJob.altContactNo
            break;
        
        case 7:
            cell.lblTitle.text = "RECRUITER DESIGNATION"
            cell.lblvalue.text = modelJob.recruiterDesignation
            break;
        
        case 8:
            cell.lblTitle.text = "INTERVIEW DATE"
            cell.lblvalue.text = modelJob.interviewDate
            break;
        
        case 9:
            cell.lblTitle.text = "HIRING FIRM"
            cell.lblvalue.text = modelJob.firmName
            break;
        
        case 10:
            cell.lblTitle.text = "JOB LOCATION"
            cell.lblvalue.text = modelJob.jobLocation
            
            break;
        
        default:
            cell.lblTitle.text = "JOB DESCRIPTION"
            cell.lblvalue.text = modelJob.jobDescription
            break;
        }
        
        return cell
    }
    @IBAction func btnSendMailClick(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
            showTitleBarAlert(message: "Configure mail first.")
            return
        }
        
        let mailViewController = MFMailComposeViewController()
        mailViewController.setToRecipients([modelJob.emailId])
        mailViewController.delegate = self
        present(mailViewController, animated: true, completion: nil)
    }
    
    //MARK:- mailviewcontroller delegate methods 
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
