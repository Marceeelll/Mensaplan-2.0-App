//
//  MensaSelectionTableViewDataSource.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class MensaSelectionTableViewDataSource : NSObject, UITableViewDataSource {
    let data = Canteen.allCanteens
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let canteen = getCanteen(at: indexPath)
        cell.textLabel?.text = canteen.mensaName
        cell.accessoryType = canteen == userProfile.canteen ? .checkmark : .none
        return cell
    }
    
    func getCanteen(at indexPath: IndexPath) -> Canteen {
        return data[indexPath.row]
    }
}
