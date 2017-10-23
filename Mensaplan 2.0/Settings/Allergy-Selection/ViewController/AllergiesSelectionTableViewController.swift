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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = AllergiesTableViewSelectionDelegate()
        dataSource = AllergiesTableViewSelectionDataSource()
        
        tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        view.addSubview(tableView) // 🚨 BUG: Im Landscape Modus ----> Constraints setzen
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
