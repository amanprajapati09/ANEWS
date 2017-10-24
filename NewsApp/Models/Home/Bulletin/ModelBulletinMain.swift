//
//	ModelBulletinMain.swift
//
//	Create by Aman Prajapati on 24/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ModelBulletinMain : BaseModel {

	var bulletinList = [ModelBulletin]()
	var totalPageCount : Int?


    override func mapping(map:Map) {
        super.mapping(map: map)
		bulletinList <- map["data"]
		totalPageCount <- map["total_page_count"]
		
	}
}
