//
//  FormViewButtonTableViewCell.swift
//  Pods
//
//  Created by Alex Bechmann on 08/06/2015.
//
//

import UIKit

public class FormViewButtonCell: FormViewCell {

    public var button = UIButton()
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        setupButton()
    }

    func setupButton() {
        
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(button)
        button.fillSuperView(UIEdgeInsetsZero)
        
        button.setTitle(config.labelText, forState: UIControlState.Normal)
        button.titleLabel?.textColor = config.buttonTextColor
        button.addTarget(self, action: "buttonTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func buttonTapped() {
        
        formViewDelegate?.formViewButtonTapped(config)
    }
}
