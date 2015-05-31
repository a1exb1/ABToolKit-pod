//
//  UIColor+Extension.swift
//  Pods
//
//  Created by Alex Bechmann on 31/05/2015.
//
//

import Foundation

extension UIColor{
    
    class func randomColor() -> UIColor {
        
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}