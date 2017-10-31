//
//	Data.swift
//
//	Create by Aman Prajapati on 30/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Data : BaseModel {

//	var categoryList : [Category]?
	var jobList : [Category]?
	var liostingList : [Category]?
	var mediaList : [Category]?
	var regionList : [Category]?
    var bullatineList : [Category]?
    

	override func mapping(map: Map) {
//		categoryList <- map["Category"]
		jobList <- map["JOB"]
		liostingList <- map["LISTING"]
		mediaList <- map["MEDIA"]
		regionList <- map["REGION"]
        bullatineList <- map["BULLETIN"]
	}
}
