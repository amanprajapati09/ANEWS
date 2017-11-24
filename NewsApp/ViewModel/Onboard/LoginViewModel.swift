
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
    
    func saveLoginInfo(model:ModelUser)  {
        userDefault.setValue(model.id, forKey: MyUserDefault.USER_ID)
        userDefault.setValue(model.emailId, forKey: MyUserDefault.USER_EMAIL)
        userDefault.setValue(model.address, forKey: MyUserDefault.USER_ADDRESS)
        userDefault.setValue(model.firstName, forKey: MyUserDefault.USER_FIRSTNAME)
        userDefault.setValue(model.roleId, forKey: MyUserDefault.USER_ROLE_ID)
        userDefault.setValue(model.status, forKey: MyUserDefault.USER_STATUS)
        userDefault.setValue(model.mobileNo, forKey: MyUserDefault.USER_PHONE)
    }
}
