//
//  AllergiesSelectionDelegate.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 22.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class AllergiesTableViewSelectionDelegate: NSObject, UITableViewDelegate  {
    let handicapCtrl = HandicapController()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            let lifestyle = Handicap.lifestyle[indexPath.row]
            handicapCtrl.add(handicap: lifestyle)
            tableView.reloadData()
        case 1:
            let allergy = Handicap.allergies[indexPath.row]
            handicapCtrl.add(handicap: allergy)
            tableView.reloadData()
        default:
            let ingredient = Ingredient.allIngredients[indexPath.row]
            userProfile.addOrRemove(ingredient: ingredient)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = cell?.accessoryType == .checkmark ? .none : .checkmark
        }
    }
}
