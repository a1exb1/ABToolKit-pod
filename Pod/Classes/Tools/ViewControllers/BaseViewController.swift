//
//  BaseViewController.swift
//  Pods
//
//  Created by Alex Bechmann on 30/05/2015.
//
//

import UIKit

@objc protocol BaseViewControllerDelegate {
    
    func preferredNavigationBar()
}

enum ConstraintReference {
    
    case None
    case Top
    case Left
    case Right
    case Bottom
}

public class BaseViewController: UIViewController {
    
    var tableViews: Array<UITableView> = []
    
    public var refreshRequest: JsonRequest?
    var tableViewConstraints = Dictionary<ConstraintReference, NSLayoutConstraint>()
    
    public var shouldDeselectCellOnViewWillAppear = true
    var shouldAdjustTableViewInsetsForKeyboard = true
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if shouldDeselectCellOnViewWillAppear {
            
            for tableView in tableViews {
                
                deselectSelectedCell(tableView)
            }
        }
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        refreshRequest?.cancel()
    }
    
    public func setupTableView(tableView: UITableView, delegate: UITableViewDelegate, dataSource:UITableViewDataSource) {
        
        view.addSubview(tableView)
        
        setupTableViewConstraints(tableView)
        
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableViews.append(tableView)
        
        tableView.reloadData()
    }
    
    public func setupTableViewRefreshControl(tableView: UITableView) {
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.AllEvents)
        tableView.addSubview(refreshControl)
    }
    
    public func setupTableViewConstraints(tableView: UITableView) {
        
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let constraints = tableView.fillSuperView(UIEdgeInsetsZero)
        tableViewConstraints[.Top] = constraints[0]
        tableViewConstraints[.Left] = constraints[1]
        tableViewConstraints[.Bottom] = constraints[2]
        tableViewConstraints[.Right] = constraints[3]
    }
    
    public func refresh(refreshControl: UIRefreshControl?) {
        
    }
    
    public func deselectSelectedCell(tableView: UITableView) {
        
        if let indexPath = tableView.indexPathForSelectedRow() {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    //MARK: - Dismiss view controller
    
    public func dismissViewControllerFromCurrentContextAnimated(animated: Bool) {
        
        if navigationController?.viewControllers.count > 1 {
            
            navigationController?.popViewControllerAnimated(animated)
        }
        else {
            
            dismissViewControllerAnimated(animated, completion: nil)
        }
    }
    
    //MARK: - Notification methods
    
    func keyboardDidChangeFrame(notification:NSNotification){
        
        if shouldAdjustTableViewInsetsForKeyboard {
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                
                for tableView in tableViews {
                    
                    if keyboardSize.origin.y == UIScreen.mainScreen().bounds.size.height {
                        
                        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
                        
                    } else {
                        
                        let bottomOffset = keyboardSize.height
                        
                        tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomOffset, 0)
                        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, bottomOffset, 0)
                    }
                    
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
        }
    }
}

