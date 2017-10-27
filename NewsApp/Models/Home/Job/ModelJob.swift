//
//	ModelJob.swift
//
//	Create by Aman Prajapati on 27/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ModelJob : ModelBaseHome{

	var altContactNo : String?
	var contactNo : String?
	var contactPerson : String?
	var emailId : String?
	var firmAddress : String?
	var firmName : String?
	var interviewDate : String?
	var jobDescription : String?
	var jobLocation : String?
	var jobTitle : String?
	var noOfPost : String?
	var recruiterDesignation : String?
	var regionId : String?
	var salary : String?
	var userId : String?

	override func mapping(map: Map)
	{
        super.mapping(map: map)
		altContactNo <- map["alt_contact_no"]
		
		contactNo <- map["contact_no"]
		contactPerson <- map["contact_person"]
		
		emailId <- map["email_id"]
		firmAddress <- map["firm_address"]
		firmName <- map["firm_name"]
		
		interviewDate <- map["interview_date"]
		jobDescription <- map["job_description"]
		jobLocation <- map["job_location"]
		jobTitle <- map["job_title"]
		
		noOfPost <- map["no_of_post"]
		recruiterDesignation <- map["recruiter_designation"]
		regionId <- map["region_id"]
		salary <- map["salary"]
		status <- map["status"]
		userId <- map["user_id"]
		
	}

}
