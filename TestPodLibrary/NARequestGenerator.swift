//
//  NARequestGenerator.swift
//  SnowRoll
//
//  Created by Netaround Developer on 11/10/16.
//  Copyright © 2016 Netaround Developer. All rights reserved.
//

import UIKit
import Alamofire

typealias NAAPIManagerData = [String: Any]

class NARequestGenerator: NSObject {
    
    // MARK: -
    // MARK: Public Properites
    
    static let sharedInstance = NARequestGenerator()
    
    // MARK: - 
    // MARK: Life Cycle
    
    private override init() {
        super.init()
    }
    
    // MARK: - Public Methods
    
    func generateGETRequest(serviceIdentifier: String, requestParams: NAAPIManagerData, methodName: String) -> DataRequest {
        let service = NAServiceFactory.sharedInstance.service(with: serviceIdentifier)
        
        var urlString: String! = nil
        
        if let apiBaseUrl = service.apiBaseURL {
            if let apiVersion = service.apiVersion {
                urlString = "\(apiBaseUrl)/\(apiVersion)/\(methodName)"
            } else {
                urlString = "\(apiBaseUrl)/\(methodName)"
            }
        } else {
            assertionFailure("Service should contain base url.")
        }
        
        var header = [String: String]()
        if let accessToken = NAAppContext.sharedInstance.accessToken {
            header["Authorization"] = accessToken
        }
        
        let request = Alamofire.request(urlString, method: .get, parameters: requestParams, encoding: URLEncoding.default, headers: header)
        
        return request
    }

    func generatePOSTRequest(serviceIdentifier: String, requestParams: NAAPIManagerData, methodName: String) -> DataRequest {
        let service = NAServiceFactory.sharedInstance.service(with: serviceIdentifier)
        
        var urlString: String! = nil

        if let apiBaseUrl = service.apiBaseURL {
            if let apiVersion = service.apiVersion {
                urlString = "\(apiBaseUrl)/\(apiVersion)/\(methodName)"
            } else {
                urlString = "\(apiBaseUrl)/\(methodName)"
            }
        } else {
            assertionFailure("Service should contain base url.")
        }
        
        var header = [String: String]()
        if let accessToken = NAAppContext.sharedInstance.accessToken {
            header["Authorization"] = accessToken
        }
        
        let request = Alamofire.request(urlString, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: header)
        
        return request
    }
    
    func generatePUTRequest(serviceIdentifier: String, requestParams: NAAPIManagerData, methodName: String) -> DataRequest {
        let service = NAServiceFactory.sharedInstance.service(with: serviceIdentifier)
        
        var urlString: String! = nil
        
        if let apiBaseUrl = service.apiBaseURL {
            if let apiVersion = service.apiVersion {
                urlString = "\(apiBaseUrl)/\(apiVersion)/\(methodName)"
            } else {
                urlString = "\(apiBaseUrl)/\(methodName)"
            }
        } else {
            assertionFailure("Service should contain base url.")
        }
        
        var header = [String: String]()
        if let accessToken = NAAppContext.sharedInstance.accessToken {
            header["Authorization"] = accessToken
        }
        
        let request = Alamofire.request(urlString, method: .put, parameters: requestParams, encoding: URLEncoding.default, headers: header)
        
        return request
    }
    
    func generateDELETERequest(serviceIdentifier: String, requestParams: NAAPIManagerData, methodName: String) -> DataRequest {
        let service = NAServiceFactory.sharedInstance.service(with: serviceIdentifier)
        
        var urlString: String! = nil
        
        if let apiBaseUrl = service.apiBaseURL {
            if let apiVersion = service.apiVersion {
                urlString = "\(apiBaseUrl)/\(apiVersion)/\(methodName)"
            } else {
                urlString = "\(apiBaseUrl)/\(methodName)"
            }
        } else {
            assertionFailure("Service should contain base url.")
        }
        
        var header = [String: String]()
        if let accessToken = NAAppContext.sharedInstance.accessToken {
            header["Authorization"] = accessToken
        }
        
        let request = Alamofire.request(urlString, method: .delete, parameters: requestParams, encoding: URLEncoding.default, headers: header)
        
        return request
    }
}
