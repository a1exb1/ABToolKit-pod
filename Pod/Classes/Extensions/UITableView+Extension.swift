//
//  UITableView+Extension.swift
//  Pods
//
//  Created by Alex Bechmann on 08/06/2015.
//
//

import UIKit

extension UITableView {
    
    func dequeTableViewCellOrCreate(identifier: String, requireNewCell: () -> (UITableViewCell)) -> UITableViewCell {
        
        if let dequeuedCell = dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell {
            
            return dequeuedCell
        }
        else {
            
            return requireNewCell()
        }
    }
}