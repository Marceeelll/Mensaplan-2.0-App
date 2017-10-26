//
//  MensaSelectionViewController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import UIKit

class MensaSelectionTableViewController: UITableViewController {
    // MARK: - Instance Variable
    var selectionDelegate: MensaSelectionDelegate!
    
    private var delegate: MensaSelectionTableViewDelegate!
    private var dataSource: MensaSelectionTableViewDataSource!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tintColor = appColor.tableViewCellTintColor
        
        delegate = MensaSelectionTableViewDelegate(selectionDelegate: selectionDelegate)
        dataSource = MensaSelectionTableViewDataSource()
        
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
