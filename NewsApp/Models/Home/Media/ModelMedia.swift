//
//	ModelMedia.swift
//
//	Create by Aman Prajapati on 24/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class ModelMedia : ModelBaseHome {
    
    var descriptionField : String?
    var image : String?
    var link : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return ModelMedia()
    }
    
    override func mapping(map:Map) {
        super.mapping(map: map)
        
        descriptionField <- map["description"]
        image <- map["image"]
        link <- map["link"]
        
    }
    
    var imageUrl:URL! {
        return URL(string:  StaticURL.IMAGE_URL + image!)
    }
}
