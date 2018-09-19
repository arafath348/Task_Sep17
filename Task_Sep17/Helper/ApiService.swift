//
//  ApiService.swift
//  Task_Sep17
//
//  Created by L-156157182 on 19/09/18.
//

import Foundation
import Alamofire
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

open class ApiService: NSObject
{
    open var rootUrl: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    open var data: JSON
  
    public init(rootUrl: String = "", data: Dictionary<String, AnyObject> = [:]) {
        self.data = JSON(data)
    }

    open func isNew() -> Bool {
        if (self.data["id"].exists()) {
            return false
        }
        return true
    }
    
    // MARK: - Rest API helper methods
    //Send GET request.
    open func fetch(data parameters: Dictionary<String, String> = [:], success: ((_ response: JSON) -> ())? = nil, error: ((_ response: JSON) -> ())? = nil) {
        if (self.isNew()) {
            print(self.rootUrl)
            self.request(method: "get", url: self.rootUrl, data: parameters, success: success, error: error)
        } else {
            self.request(method: "get", url: self.rootUrl + "/" + self.data["id"].stringValue, data: parameters, success: success, error: error)
        }
    }
    
    //Send POST/PUT request.
    open func save(data parameters: Dictionary<String, String> = [:], encoding: ParameterEncoding = JSONEncoding.default, success: ((_ response: JSON) -> ())? = nil, error: ((_ response: JSON) -> ())? = nil) {
        if (self.isNew()) {
            self.request(method: "post", url: self.rootUrl, data: parameters, encoding: encoding, success: success, error: error)
        } else {
            self.request(method: "put", url: self.rootUrl + "/" + self.data["id"].stringValue, data: parameters, encoding: encoding, success: success, error: error)
        }
        
    }
    
    //Send DELETE request
    open func destroy(success: ((_ response: JSON) -> ())? = nil, error: ((_ response: JSON) -> ())? = nil) {
        if (!self.isNew()) {
            self.request(method: "delete", url: self.rootUrl + "/" + self.data["id"].stringValue, success: success, error: error)
        }
    }
    
    //Send HTTP request.
    open func request(method:String = "", url: String = "", data parameters: Dictionary<String, String> = [:], headers: Dictionary<String, String> = [:], encoding: ParameterEncoding = URLEncoding.default, success: ((_ response: JSON) -> ())? = nil, error: ((_ response: JSON) -> ())? = nil) {
        
        // Check internet connectivity
        if !Connectivity.isConnectedToInternet {
            let alert = UIAlertController(title: "Alert!", message: "Please check your internet connection", preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        else{
        var requestMethod: Alamofire.HTTPMethod
        switch method {
        case "post":
            requestMethod = .post
        case "put":
            requestMethod = .put
        case "delete":
            requestMethod = .delete
        default:
            requestMethod = .get
        }
        

        Alamofire.request(url, method: requestMethod, parameters: parameters, encoding: encoding, headers: headers)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let value):
                    let data = value.data(using: .utf8)!
                    if let json = try? JSON(data: data) {
                        self.data = json
                        if let success = success {
                            success(json)
                        }
                    }

                case .failure(let responseError):
                    var json = JSON(["error": responseError.localizedDescription])
                    if let responseStatus = response.response?.statusCode {
                        json["status"] = JSON(responseStatus)
                    }
                    
                    if let error = error {
                        error(json)
                    }
                }
            }
            
        }
    }
}
