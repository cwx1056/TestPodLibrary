//
//  NAService.swift
//  SnowRoll
//
//  Created by Netaround Developer on 11/10/16.
//  Copyright © 2016 Netaround Developer. All rights reserved.
//

import UIKit

protocol NAServiceProtocol: class {
    var isOnline: Bool { get }
    
    var offlineApiBaseUrl: String { get }
    var onlineApiBaseUrl: String { get }
    
    var offlineApiVersion: String { get }
    var onlineApiVersion: String { get }
    
    var offlinePublicKey: String { get }
    var onlinePublicKey: String { get }
    
    var offlinePrivateKey: String { get }
    var onlinePrivateKey: String { get }
}

class NAService: NSObject {
    
    struct ServiceIdentifier {
        static var kNAServiceSnowRollV1 = "kNAServiceSnowRollV1"
    }
    
    // MARK: -
    // MARK: Public Properties
    var publicKey: String? {
        if let child = self.child {
            return child.isOnline ? child.onlinePublicKey : child.offlinePublicKey
        } else {
            return nil
        }
    }
    
    var privateKey: String? {
        if let child = self.child {
            return child.isOnline ? child.onlinePrivateKey : child.offlinePrivateKey
        } else {
            return nil
        }
    }
    
    var apiBaseURL: String? {
        if let child = self.child {
            return child.isOnline ? child.onlineApiBaseUrl : child.offlineApiBaseUrl
        } else {
            return nil
        }
    }
    
    var apiVersion: String? {
        if let child = self.child {
            return child.isOnline ? child.onlineApiVersion : child.offlineApiVersion
        } else {
            return nil
        }
    }

    weak var child: NAServiceProtocol?
    
    // MARK: -
    // MARK: Life Cycle
    
    override init() {
        super.init()
        
        if let _ = self as? NAServiceProtocol{
            self.child = self as? NAServiceProtocol
        }
    }
}
