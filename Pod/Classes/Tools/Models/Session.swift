//
//  Session.swift
//  Pods
//
//  Created by Alex Bechmann on 01/06/2015.
//
//

import UIKit

private var kSessionSharedInstance: Session? = nil

public class Session: NSObject {
   
    var domain: String = ""
    
    public class func initializeSession() {
        
        kSessionSharedInstance = Session()
    }
    
    public class func sharedSession() -> Session? {
        
        return kSessionSharedInstance
    }
}
