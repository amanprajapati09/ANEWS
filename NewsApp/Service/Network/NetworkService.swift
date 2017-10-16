//
//  NetworkService.swift
//
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import UIKit

typealias Completion = (DataResponse<Any>) -> Void
let center = NotificationCenter.default
var alamoFireManager: Alamofire.SessionManager?

class NetworkService : NSObject {
    
    static let shared = NetworkService()
    var headers = [String: String]()
    
    private override init()
    {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        setAuthorizationToken()
        
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    //MARK: Header Setting
    func setAuthorizationToken() {

//        if UserStateHolder.isUserLoggedIn {
//            
//            if let token = UserStateHolder.loggedInUser?.token! {
//                headers["Authorization"] = "Bearer \(token)"
//            }
//            
//        }
        headers["Content-type"] = "application/json"
    }
    
    func removeAuthorizationToken() {
        
        headers.removeValue(forKey: "Authorization")
    }
    
    func setDeviceInfo(deviceId:String, deviceToken:String) {
        //print("Device-Id \(deviceId)")
        //print("Device-Token \(deviceToken)")
//        headers["Device-Id"] = deviceId
//        headers["Device-Token"] = deviceToken
    }
    
    //MARK: Mappable Webcall
    func callWebService<T: BaseMappable>(method:HTTPMethod, path:URLConvertible,params:[String:AnyObject]?,type:ParameterEncoding, completion:@escaping (Alamofire.DataResponse<T>) -> Void) -> Void {
        
        alamoFireManager?.request(path, method: method, parameters: params, encoding: type, headers: headers).responseObject {
            (completionHandler) in
                completion(completionHandler)
        }
    }
    
    //MARK: Without Mappable Webcall
    func callWebServiceWithoutMapping(method:HTTPMethod, path:URLConvertible,params:[String:AnyObject]?,type:ParameterEncoding, completion:@escaping Completion) -> Void {
        
        alamoFireManager?.request(path, method: method, parameters: params, encoding: type, headers: headers).responseJSON {
            (completionHandler) in
            completion(completionHandler)
        }
    }
    
    //MARK: Mappable with return Request data 
    //use this method for if you want to cancel request
    func callWebServiceWithRequestObject<T: BaseMappable>(method:HTTPMethod, path:URLConvertible,params:[String:AnyObject]?,type:ParameterEncoding, completion:@escaping (Alamofire.DataResponse<T>) -> Void) -> DataRequest {
        
        return (alamoFireManager?.request(path, method: method, parameters: params, encoding: type, headers: headers).responseObject {
            (completionHandler) in
            completion(completionHandler)
            })!
    }
    
    func printResponse(data:NSData?) {
        if data != nil {
            //print(String(data: data! as Data, encoding: String.Encoding.utf8))
        }
    }
    
    func cancelAllRequest() {
        alamoFireManager?.session.getTasksWithCompletionHandler{ (dataTasks, uploadTasks, DownloadTasks) in
            dataTasks.forEach{ $0.cancel() }
            uploadTasks.forEach{ $0.cancel() }
            DownloadTasks.forEach{ $0.cancel() }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }    
}
