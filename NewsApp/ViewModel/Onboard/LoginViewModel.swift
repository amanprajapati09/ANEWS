
//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/11/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation

struct LoginViewModel {
    
    func createLoginParams(username:String, password:String) -> [String:Any] {
        return ["email_id":username,
        "password":password] as [String:Any]
    }
    
    func createForgotParams(email:String) -> [String:Any] {
        return ["email_id":email] as [String:Any]
    }
}
