//
//  NAAppContext.swift
//  SnowRoll
//
//  Created by Netaround Developer on 11/10/16.
//  Copyright © 2016 Netaround Developer. All rights reserved.
//

import UIKit
import Alamofire

class NAAppContext: NSObject {
    
    // MARK: -
    // MARK: Public Properties
    
    static let sharedInstance = NAAppContext()
    
    // Device Info
    var type: String {
        return "ios"
    }
    
    var model: String {
        return UIDevice.current.name
    }
    
    var os: String {
        return UIDevice.current.systemVersion
    }
    
    var rom: String {
        return UIDevice.current.model
    }
    
    var imei: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    var imsi: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    var deviceName: String {
        return UIDevice.current.name
    }
    
    var resolution: CGSize {
        var result = CGSize.zero
        
        if self.deviceName == "iPod1,1" ||
           self.deviceName == "iPod2,1" ||
           self.deviceName == "iPod3,1" ||
           self.deviceName == "iPhone1,1" ||
           self.deviceName == "iPhone1,2" ||
           self.deviceName == "iPhone2,1" {
            
            result = CGSize(width: 320, height: 480)
        } else if self.deviceName == "iPod4,1" ||
                  self.deviceName == "iPhone3,1" ||
                  self.deviceName == "iPhone3,3" ||
            self.deviceName == "iPhone4,1" {
            
            result = CGSize(width: 640, height: 960)
        } else if self.deviceName == "iPhone5,1" ||
                  self.deviceName == "iPhone5,2" ||
                  self.deviceName == "iPhone5,3" ||
                  self.deviceName == "iPhone5,4" ||
                  self.deviceName == "iPhone6,1" ||
                  self.deviceName == "iPhone6,2" {
            
            result = CGSize(width: 640, height: 1136)
        } else if self.deviceName == "iPhone7,1" {
            
            result = CGSize(width: 1080, height: 1920)
        } else if self.deviceName == "iPhone7,2" {
            
            result = CGSize(width: 750, height: 1024)
        } else if self.deviceName == "iPad1,1" ||
                  self.deviceName == "iPad2," {
            
            result = CGSize(width: 768, height: 1024)
        } else if self.deviceName == "iPad3,1" ||
                  self.deviceName == "iPad3,4" ||
                  self.deviceName == "iPad4,1" ||
                  self.deviceName == "iPad4,2" {
            
            result = CGSize(width: 1536, height: 2048)
        } else if self.deviceName == "iPad2,5" {
            
            result = CGSize(width: 768, height: 1024)
        } else if self.deviceName == "iPad4,4" ||
                  self.deviceName == "iPad4,5" {
            
            result = CGSize(width: 1536, height: 2048)
        } else {
            result = CGSize(width: 640, height: 960)
        }

        return result
    }
    
    // Network evironment
    var isReachable: Bool = true
    
    var isOnline: Bool {
        var result = false
        
        if let filePath = Bundle.main.path(forResource: "NANetworkingConfiguration", ofType: "plist"),
            FileManager.default.fileExists(atPath: filePath),
            let settings = NSDictionary(contentsOfFile: filePath) as? [String: AnyObject] {
            result = settings["isOnline"] as? Bool ?? false
        }
        
        return result
    }
    
    var reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    
    // Token info
    lazy var accessToken: String? = {
        return UserDefaults.standard.string(forKey: "accessToken")
    }()
    
    lazy var refreshToken: String? = {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }()
    
    var lastRefreshTime: TimeInterval = 0
    
    // User Info
    var userInfo: [String: AnyObject]? {
        get {
            return UserDefaults.standard.object(forKey: "userInfo") as! [String : AnyObject]?
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userInfo")
            UserDefaults.standard.synchronize()
        }
    }
    
    var userId: String {
        get {
            return UserDefaults.standard.string(forKey: "userId") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
            UserDefaults.standard.synchronize()
        }
    }
    
    var isLoggedIn: Bool {
        let result = self.userId.characters.count != 0
        return result
    }
    
    // app Info
    
    var sessionId: String!
    var appVersion: String {
        
        // FIXME: Make it perfect
        var result: String = ""
        
        if let info = Bundle.main.infoDictionary {
            result = info["CFBundleVersion"] as? String ?? ""
        }
        
        return result
    }
    
    // Push Notification
    
    lazy var deviceTokenData: Data = {
       return Data()
    }()
    
    lazy var deviceToken: String = {
       return ""
    }()
    
//    var updateTokenAPIManager: NAAPIBaseManager?
    
    // The geographical position
    
    var latitude: CGFloat {
        return 0.0
    }
    
    var longitude: CGFloat {
        return 0.0
    }
    
    // MARK: Private Properties
    
    
    // MARK: -
    // MARK: Life Cycle
    
    private override init() {
        super.init()
        
        // TODO: |TEST| reachable
        self.reachabilityManager?.listener = { [unowned self] status in
            switch status {
            case .notReachable:
                self.isReachable = false
            case .reachable(_), .unknown:
                self.isReachable = true
            }
        }
        
        self.reachabilityManager?.startListening()
    }
    
    // MARK: -
    // MARK: Public Methods
    
    func update(accessToken: String, refreshToken: String) {

        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.lastRefreshTime = Date().timeIntervalSince1970 * 1000
        
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.synchronize()
    }
    
    func cleanUserInfo() {
        
    }
    
    func appStarted() {
        self.sessionId = UUID().uuidString
        
        // TODO: start location manager
    }
    
    func appEnded() {
        // TODO: end location manager
    }
}
