//
//  APIService.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//
/*
 1. Open Link
 
 2. Follow instructions in Safari
 
 3. Return to the Activate App
 */

import Foundation
import UIKit
import Alamofire

typealias Success = (_ result: AnyObject) -> (Void)
typealias Failure = (_ error: String) -> (Void)

class APIService : NSObject {
    
    //MARK:- SharedInstance
    static let sharedInstance = APIService()
    
    //MARK: Error Code
    var errorCodeList:[Int]?
    
    //MARK:- Init
    private override init() {
        
        super.init()
        errorCodeList = [400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,421,422,423,424,425,426,427,428,429,431,451,-1009]
    }
    
    //MARK:- Error Handling
    func handleError(error:NSError?, failure:Failure, responseCode:Int?) -> Bool
    {
        if let httpError = error {
            let statusCode = httpError.code
            
            if statusCode == -1009 {
                //                showStatusBarAlert(Str: AlertTitle.NETWORK_ERROR, Duration: 2.0)
                failure(AlertTitle.kAlertTitleNoInternet)
            }
            else if statusCode == -1005 {
                //                showStatusBarAlert(Str: AlertTitle.NETWORK_ERROR, Duration: 2.0)
                failure(AlertTitle.kAlertTitleNoInternet)
            }
            else if statusCode == -999
            { // opration cancel by us so no process more
                failure(AlertTitle.kAlertTitleGeneralError)
            }
            else
            {
                failure(AlertTitle.kAlertTitleGeneralError)
                //                showStatusBarAlert(Str: AlertTitle.ALERT_WEBSERVICE_ERROR , Duration: 2.0)
            }
            return true
        }
        else if responseCode != nil && errorCodeList!.contains(responseCode!) {
            if (responseCode == 401 || responseCode == 400)
            {
                return true
            }
        }
        return false
    }
    
    //MARK:- Request for login
    func login(parameters params: [String: AnyObject], success:@escaping (_ result: ModelLogin) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.LOGIN, params: params, type: JSONEncoding()){
            (completion:DataResponse<ModelLogin>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    //MARK:- Request for Registration
    func registration(parameters params: [String: AnyObject], success:@escaping (_ result: ResultModel) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.SIGNUP, params: params, type: JSONEncoding()){
            (completion:DataResponse<ResultModel>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func forgotPassword(parameters params: [String: AnyObject], success:@escaping (_ result: ResultModel) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.FORGOT_PASSWORD, params: params, type: JSONEncoding()){
            (completion:DataResponse<ResultModel>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func resetPassword(parameters params: [String: AnyObject], success:@escaping (_ result: ResultModel) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.RESET_PASSWORD, params: params, type: JSONEncoding()){
            (completion:DataResponse<ResultModel>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    //MARK:- home related API
    func flashList(parameters params: [String: AnyObject]?, success:@escaping (_ result: ModelFlashMain) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.FLASH, params: params, type: JSONEncoding()){
            (completion:DataResponse<ModelFlashMain>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    func list(parameters params: [String: AnyObject]?, success:@escaping (_ result: ModelListMain) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.LIST, params: params, type: JSONEncoding()){
            (completion:DataResponse<ModelListMain>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    func bulletineList(parameters params: [String: AnyObject]?, success:@escaping (_ result: ModelBulletinMain) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.BULLETIN, params: params, type: JSONEncoding()){
            (completion:DataResponse<ModelBulletinMain>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    func mediaList(parameters params: [String: AnyObject]?, success:@escaping (_ result: ModelMediaMain) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.MEDIA, params: params, type: JSONEncoding()){
            (completion:DataResponse<ModelMediaMain>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func jobList(parameters params: [String: AnyObject]?, success:@escaping (_ result: ModelJobMain) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.JOB, params: params, type: JSONEncoding()){
            (completion:DataResponse<ModelJobMain>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func CategoryList(parameters params: [String: AnyObject]?, success:@escaping (_ result: CategoryMain) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .get, path: PATH.CATEGORY, params: params, type: JSONEncoding()){
            (completion:DataResponse<CategoryMain>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func AddPostJob(parameters params: [String: AnyObject], success:@escaping (_ result: ResultModel) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.POSTJOB, params: params, type: JSONEncoding()){
            (completion:DataResponse<ResultModel>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func ratingList(parameters params: [String: AnyObject], success:@escaping (_ result: RatingListMain) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.REVIEW_LIST, params: params, type: JSONEncoding()){
            (completion:DataResponse<RatingListMain>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func submitReview(parameters params: [String: AnyObject], success:@escaping (_ result: ResultModel) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.SUBMIT_REVIEW, params: params, type: JSONEncoding()){
            (completion:DataResponse<ResultModel>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func listDetail(parameters params: [String: AnyObject], success:@escaping (_ result: ListDetailMain) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.LIST_DETAIL, params: params, type: JSONEncoding()){
            (completion:DataResponse<ListDetailMain>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }
    
    func editProfile(parameters params: [String: AnyObject], success:@escaping (_ result: ResultModel) -> (Void), failure:@escaping Failure) -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkService.shared.callWebService(method: .post, path: PATH.EDIT_PROFILE, params: params, type: JSONEncoding()){
            (completion:DataResponse<ResultModel>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if !self.handleError(error: completion.result.error as NSError?, failure: failure, responseCode: completion.response?.statusCode)
            {
                success(completion.result.value!)
            } else {
                
                if let msg = completion.result.value?.message {
                    failure(msg)
                }
            }
        }
    }


}
