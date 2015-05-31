//
//  UIView+Animations.swift
//  Pods
//
//  Created by Alex Bechmann on 31/05/2015.
//
//

import UIKit

public extension UIView {

    public func animateConstraintChange(duration: NSTimeInterval) {
        
        UIView.animateWithDuration(duration, animations: { () in
            self.layoutIfNeeded()
        })
    }
}
