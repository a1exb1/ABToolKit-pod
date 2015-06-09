//
//  FormViewTextFieldTableViewCell.swift
//  topik-ios
//
//  Created by Alex Bechmann on 31/05/2015.
//  Copyright (c) 2015 Alex Bechmann. All rights reserved.
//

import UIKit

let kPadding: CGFloat = 10

public class FormViewTextFieldCell: FormViewCell {

    public var label = UILabel()
    public var textField = UITextField()
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(label)
        
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(textField)
        textField.textAlignment = NSTextAlignment.Right
        
        setupLabelConstraints()
        setupTextFieldConstraints()
    
        if configuation.formCellType == FormCellType.TextFieldCurrency {
            
            textField.keyboardType = UIKeyboardType.DecimalPad
        }
        
        textField.delegate = self
    }

    // MARK: - Constraints
    
    public func setupLabelConstraints() {
        
        label.addTopConstraint(toView: contentView, relation: .Equal, constant: 0)
        label.addLeftConstraint(toView: contentView, relation: .Equal, constant: kPadding)
        label.addBottomConstraint(toView: contentView, relation: .Equal, constant: 0)
        label.addWidthConstraint(relation: .Equal, constant: 160)
    }
    
    public func setupTextFieldConstraints() {
        
        textField.addTopConstraint(toView: contentView, relation: .Equal, constant: 0)
        textField.addLeftConstraint(toView: label, attribute: NSLayoutAttribute.Right, relation: .Equal, constant: 0)
        textField.addRightConstraint(toView: contentView, relation: .Equal, constant: -kPadding)
        textField.addBottomConstraint(toView: contentView, relation: .Equal, constant: 0)
    }

}


extension FormViewTextFieldCell: UITextFieldDelegate {
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if configuation.formCellType == FormCellType.TextFieldCurrency {
            
            // Construct the text that will be in the field if this change is accepted
            var oldText = textField.text as NSString
            var newText = oldText.stringByReplacingCharactersInRange(range, withString: string) as NSString!
            var newTextString = String(newText)
            
            let digits = NSCharacterSet.decimalDigitCharacterSet()
            var digitText = ""
            for c in newTextString.unicodeScalars {
                if digits.longCharacterIsMember(c.value) {
                    digitText.append(c)
                }
            }
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            formatter.locale = configuation.currencyLocale
            var numberFromField = (NSString(string: digitText).doubleValue)/100
            newText = formatter.stringFromNumber(numberFromField)
            
            textField.text = String(newText)
            delegate?.valueDidChange(configuation.identifier, value: numberFromField)
            
            return false
        }
        
        else {
            
            delegate?.valueDidChange(configuation.identifier, value: string)
        }
        
        return true
    }
}
