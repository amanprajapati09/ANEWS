//
//  ChangePasswordViewModel.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/21/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation

struct ChangePasswordViewModel {
 
    func prepareParams(oldPassword:String, newPassword:String) -> [String:Any] {
        return ["user_id":userDefault.value(forKey: MyUserDefault.USER_ID),
                "old_password":oldPassword,
                "new_password":newPassword]
    }
}
