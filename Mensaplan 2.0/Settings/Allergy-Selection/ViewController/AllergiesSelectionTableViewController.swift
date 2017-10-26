//
//  AllergiesSelectionTableViewController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import UIKit


class AllergiesSelectionTableViewController: UIViewController {
    // MARK: - Instance Variable
    var tableView: UITableView!
    
    var delegate: AllergiesTableViewSelectionDelegate!
    var dataSource: AllergiesTableViewSelectionDataSource!
    
    var selectionDelegate: AllergiesSelectionDelegate!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = AllergiesTableViewSelectionDelegate()
        dataSource = AllergiesTableViewSelectionDataSource()
        
        tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.tintColor = appColor.tableViewCellTintColor
        view.addSubview(tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        selectionDelegate.receiveAllergies(didSelect: delegate.didChangedAllergies)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
