//
//  Double+Extension.swift
//  Pods
//
//  Created by Alex Bechmann on 08/06/2015.
//
//

import UIKit

public extension Double {
    
    public func toStringWithDecimalPlaces(decimals:Int) -> String {
        
        return String(format: "%.2f", self)
    }
    
    public func formatStringAsCurrency(locale: NSLocale) -> String {
        
        var newText:NSString = ""
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = locale
        var number = self / 100
        newText = formatter.stringFromNumber(number)!
        println("remove after testing this function")
        return String(newText)
    }
}
