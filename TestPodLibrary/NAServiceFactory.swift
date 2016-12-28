//
//  NAServiceFactory.swift
//  SnowRoll
//
//  Created by Netaround Developer on 11/10/16.
//  Copyright © 2016 Netaround Developer. All rights reserved.
//

import UIKit

class NAServiceFactory: NSObject {
    
    // MARK: -
    // MARK: Pirvate Properties
    lazy var serviceStorage: [String: NAService] = {
        return [String: NAService]()
    }()
    
    // MARK: -
    // MARK: Life Cycle
    
    static let sharedInstance = NAServiceFactory()
    private override init() {
        super.init()
    }
    
    // MARK: -
    // MARK: Public Methods
    
    func service(with identifier: String) -> NAService {
        if let service = self.serviceStorage[identifier] as? NAServiceProtocol {
            return service as! NAService
        } else {
            return self.newService(with: identifier)
        }
    }
    
    // MARK: Private Methods
    
    private func newService(with identifier: String) -> NAService {
        switch identifier {
            case NAService.ServiceIdentifier.kNAServiceSnowRollV1:
                return NAService()
            
            default:
                assertionFailure("Should create service with default sandboxService")
                return NAService()
        }
    }
}
