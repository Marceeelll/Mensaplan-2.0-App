//
//  MensaSelectionTableViewDelegate.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class MensaSelectionTableViewDelegate : NSObject, UITableViewDelegate {
    private var selectionDelegate: MensaSelectionDelegate
    
    init(selectionDelegate: MensaSelectionDelegate) {
        self.selectionDelegate = selectionDelegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dSource = tableView.dataSource as! MensaSelectionTableViewDataSource
        let selectedCanteen = dSource.getCanteen(at: indexPath)
        userProfile.set(new: selectedCanteen)
        selectionDelegate.receive(selection: indexPath, canteen: selectedCanteen)
    }
}
