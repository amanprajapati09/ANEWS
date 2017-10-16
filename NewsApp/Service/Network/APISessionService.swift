//
//  APISessionService.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class APISessionService: NSObject {

    let dataErrorMessage = "Error in  response data."
    
    var url : String = ""
    var method : String = ""
    
    func createRequest(parameters params: [String: AnyObject], success:@escaping (_ result: [String:AnyObject]) -> (Void), failure:@escaping Failure)  {
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                self.errorComplition(errorMessage: (error?.localizedDescription)!, failure: failure)
                return
            }
            guard let responseData = data else {
                self.errorComplition(errorMessage: self.dataErrorMessage, failure: failure)
                return
            }
            do {
                guard let result = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    self.errorComplition(errorMessage: self.dataErrorMessage, failure: failure)
                    return
                }
                print("The title is: " + result.description)
                
                let status = result["status"] as! Int
                
                guard status != 0 else {
                    self.errorComplition(errorMessage: result["message"] as! String, failure: failure)
                    return
                }
                
                //Call success complition on main thread
                DispatchQueue.main.async {
                    success(result)
                }
                
            } catch  {
                print("error trying to convert data to JSON")
                self.errorComplition(errorMessage: self.dataErrorMessage, failure: failure)
                return
            }
        }
        task.resume()
    }

    //Mehtod to call error complition
    func errorComplition(errorMessage:String, failure:@escaping Failure)  {
        //Call error complition on main thread
        DispatchQueue.main.async {
            failure(errorMessage)
        }
    }
    
}
