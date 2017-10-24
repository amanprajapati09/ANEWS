
//
//  StringExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/24/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDateString() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = tempLocale // reset the locale
        return dateFormatter.string(from: date)
    }
    
    func convertToTimeString() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = tempLocale // reset the locale
        return dateFormatter.string(from: date)
    }
}
