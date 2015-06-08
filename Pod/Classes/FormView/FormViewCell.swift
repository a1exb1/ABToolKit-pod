//
//  FormViewCell.swift
//  Pods
//
//  Created by Alex Bechmann on 08/06/2015.
//
//

import UIKit

public protocol FormViewCellDelegate {
    
    func valueDidChange(identifier: String, value: AnyObject)
}

public class FormViewCell: UITableViewCell {

    public var configuation = FormViewConfiguration()
    public var delegate: FormViewCellDelegate?

}
