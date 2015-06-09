//
//  FormViewController.swift
//  topik-ios
//
//  Created by Alex Bechmann on 31/05/2015.
//  Copyright (c) 2015 Alex Bechmann. All rights reserved.
//


import UIKit
import ABToolKit

private let kTextFieldCellIdenfitier = "TextFieldCell"
private let kButtonCellIdentifier = "ButtonCell"

public enum FormCellType {
    
    case None
    case DatePicker
    case TextField
    case TextFieldCurrency
    case Button
}

public class FormViewConfiguration {
    
    var labelText: String = ""
    var formCellType = FormCellType.TextField
    var value: AnyObject?
    var identifier: String = ""
    
    //currency
    var currencyLocale = NSLocale(localeIdentifier: "en_GB")
    
    //button
    var buttonTextColor = UIColor.blueColor()
    
    private convenience init(labelText: String, formCellType: FormCellType, value: AnyObject?, identifier: String) {
        
        self.init()
        self.labelText = labelText
        self.formCellType = formCellType
        self.value = value
        self.identifier = identifier
    }
    
    public class func date(labelText: String, date: NSDate?, identifier: String) -> FormViewConfiguration {
        
        return FormViewConfiguration(labelText: labelText, formCellType: FormCellType.DatePicker, value: date, identifier: identifier)
    }
    
    public class func textField(labelText: String, value: String?, identifier: String) -> FormViewConfiguration {
        
        return FormViewConfiguration(labelText: labelText, formCellType: FormCellType.TextField, value: value, identifier: identifier)
    }
    
    public class func textFieldCurrency(labelText: String, value: String?, identifier: String) -> FormViewConfiguration {
        
        return textFieldCurrency(labelText, value: value, identifier: identifier, locale: nil)
    }
    
    public class func textFieldCurrency(labelText: String, value: String?, identifier: String, locale: NSLocale?) -> FormViewConfiguration {
        
        let config = FormViewConfiguration(labelText: labelText, formCellType: FormCellType.TextFieldCurrency, value: value, identifier: identifier)
        
        if let l = locale {
            
            config.currencyLocale = l
        }
        
        return config
    }
    
    public class func button(buttonText: String, buttonTextColor: UIColor, identifier: String) -> FormViewConfiguration {
        
        let config = FormViewConfiguration(labelText: buttonText, formCellType: FormCellType.Button, value: nil, identifier: identifier)
        config.buttonTextColor = buttonTextColor
        
        return config
    }
    
    public class func normalCell(identifier: String) -> FormViewConfiguration {
        
        return FormViewConfiguration(labelText: "", formCellType: FormCellType.None, value: nil, identifier: identifier)
    }
}

public protocol FormViewDelegate {
    
    func formViewElements() -> Array<Array<FormViewConfiguration>>
    func formViewElementChanged(identifier: String, value: AnyObject)
    func formViewManuallySetCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, identifier: String) -> UITableViewCell
}

public class FormViewController: BaseViewController {
    
    var tableView = UITableView(frame: CGRectZero, style: .Grouped)
    var data: Array<Array<FormViewConfiguration>> = []
    var selectedIndexPath: NSIndexPath?
    public var formViewDelegate: FormViewDelegate?
    //var editingObjectToConfiguation: Dictionary<AnyObject, FormViewConfiguration> = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        formViewDelegate = self
        
        setupTableView(tableView, delegate: self, dataSource: self)
        reloadForm()
    }
    
    public func reloadForm() {
        
        if let elements = formViewDelegate?.formViewElements() {
            
            data = elements
        }
        
        tableView.reloadData()
    }
    
    override public func setupTableView(tableView: UITableView, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.setupTableView(tableView, delegate: delegate, dataSource: dataSource)
        
        tableView.registerClass(FormViewTextFieldCell.self, forCellReuseIdentifier: kTextFieldCellIdenfitier)
        tableView.registerClass(FormViewButtonCell.self, forCellReuseIdentifier: kButtonCellIdentifier)
        tableView.allowsSelectionDuringEditing = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
}

extension FormViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let configuration:FormViewConfiguration = data[indexPath.section][indexPath.row]
        
        if configuration.formCellType == FormCellType.DatePicker {
            
            if let path = selectedIndexPath {
                
                if indexPath == path {
                    
                    return 100
                }
            }
        }
        
        return 44
    }
    
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return data.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data[section].count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let config:FormViewConfiguration = data[indexPath.section][indexPath.row]
        
        if config.formCellType == FormCellType.TextField || config.formCellType == FormCellType.TextFieldCurrency {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(kTextFieldCellIdenfitier) as! FormViewTextFieldCell
            
            cell.delegate = self
            cell.configuation = config
            
            cell.label.text = config.labelText
            cell.textField.text = config.value as! String
            
            return cell
        }
        else if config.formCellType == FormCellType.Button {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(kButtonCellIdentifier) as! FormViewButtonCell
            
            cell.delegate = self
            cell.configuation = config
            
            return cell
        }
        else if config.formCellType == FormCellType.None {
            
            if let c = formViewDelegate?.formViewManuallySetCell(tableView, cellForRowAtIndexPath: indexPath, identifier: config.identifier) {
                
                return c
            }
        }
        
        return UITableViewCell()
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let config:FormViewConfiguration = data[indexPath.section][indexPath.row]
        
        selectedIndexPath = selectedIndexPath != indexPath ? indexPath : nil
        
        if config.formCellType == FormCellType.None || config.formCellType == FormCellType.Button {
            
            formViewDelegate?.formViewElementChanged(config.identifier, value: "")
        }
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? FormViewTextFieldCell {
            
            cell.textField.becomeFirstResponder()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension FormViewController: FormViewCellDelegate {
    
    public func valueDidChange(identifier: String, value: AnyObject) {
        
        formViewDelegate?.formViewElementChanged(identifier, value: value)
    }
}

extension FormViewController: FormViewDelegate {
    
    public func formViewElementChanged(identifier: String, value: AnyObject) {
        
        
    }
    
    public func formViewElements() -> Array<Array<FormViewConfiguration>> {
        
        return [[]]
    }
    
    public func formViewManuallySetCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, identifier: String) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
