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
    @IBOutlet weak var btnSendResume: UIButton!
    @IBOutlet weak var lblJobTitle: UILabel!
    
    var modelJob: ModelJob!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareForLanguage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func prepareView() {
        tblView.register(JobDetailTableViewCell.self)
        tblView.estimatedRowHeight = 40
        tblView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: JobDetailTableViewCell.reuseIdentifier) as! JobDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_job_title")
            cell.lblvalue.text = modelJob.jobTitle
            break;
        case 1:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_hiring_firm_name")
            cell.lblvalue.text = modelJob.firmName
            break;
        
        case 2:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_salary")
            cell.lblvalue.text = modelJob.salary
            break;
        
        case 3:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_no_of_post")
            cell.lblvalue.text = modelJob.noOfPost
            break;
        
        case 4:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_email_id")
            cell.lblvalue.text = modelJob.emailId
            break;
        
        case 5:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_contact_number1")
            cell.lblvalue.text = modelJob.contactNo
            break;
        
        case 6:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_contact_number2")
            cell.lblvalue.text = modelJob.altContactNo
            break;
        
        case 7:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_recruiter_designation")
            cell.lblvalue.text = modelJob.recruiterDesignation
            break;
        
        case 8:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_interview_date")
            cell.lblvalue.text = modelJob.interviewDate
            break;
        
        case 9:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_hiring_firm_addr")
            cell.lblvalue.text = modelJob.firmName
            break;
        
        case 10:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_job_location")
            cell.lblvalue.text = modelJob.jobLocation
            
            break;
        
        default:
            cell.lblTitle.text = localizedShared?.localizedString(forKey: "text_job_description")
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
    
    private func prepareForLanguage() {
        btnSendResume.setTitle(localizedShared?.localizedString(forKey: "text_send_resume"), for: .normal)
        lblJobTitle.text = localizedShared?.localizedString(forKey: "text_job_detail")
    }
}
