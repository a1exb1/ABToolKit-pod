//
//  NSObjec+Extension.swift
//  Pods
//
//  Created by Alex Bechmann on 01/06/2015.
//
//

import Foundation

public extension NSObject {
    
    public class func getClassName() -> String {
        
        return _stdlib_getDemangledTypeName(self).componentsSeparatedByString(".").last!
    }
}
