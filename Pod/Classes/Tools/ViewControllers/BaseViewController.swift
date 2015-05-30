//
//  BaseViewController.swift
//  Pods
//
//  Created by Alex Bechmann on 30/05/2015.
//
//

import UIKit

class BaseViewController: UIViewController {
    
    func setupTableView(tableView: UITableView, delegate: UITableViewDelegate, dataSource:UITableViewDataSource) {
        
        view.addSubview(tableView)
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView.fillSuperView(UIEdgeInsetsZero)
        
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.AllEvents)
        tableView.addSubview(refreshControl)
    }
    
    func refresh(refreshControl: UIRefreshControl?) {
        
    }
    
    func deselectTableViewSelectedCell(tableView: UITableView) {
        
        if let indexPath = tableView.indexPathForSelectedRow() {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}