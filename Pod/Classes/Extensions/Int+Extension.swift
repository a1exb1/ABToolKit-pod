//
//  Number+Extension.swift
//  Pods
//
//  Created by Alex Bechmann on 08/06/2015.
//
//

import UIKit

public extension Int {
    
    public func toStringWithDecimalPlaces(decimals:Int) -> String {
        
        return String(format: "%.2f", self)
    }
}