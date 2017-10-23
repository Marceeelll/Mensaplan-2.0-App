//
//  AllergiesSelectionDataSource.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 22.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class AllergiesTableViewSelectionDataSource: NSObject, UITableViewDataSource {
    private var headerNames: [String] = ["Lifestyle", "Allergien", "Inhaltsstoffe"]
    private var lifestyleData: [Handicap] = Handicap.lifestyle
    private var allergiesData: [Handicap] = Handicap.allergies
    private var ingredients: [Ingredient] = Ingredient.allIngredients
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:  return lifestyleData.count
        case 1:  return allergiesData.count
        default: return ingredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        switch indexPath.section {
        case 0:
            let lifestyleTyp = lifestyleData[indexPath.row]
            let isSelected = userProfile.lifestyle.contains(lifestyleTyp)
            cell.accessoryType = isSelected ? .checkmark : .none
            cell.textLabel?.text = lifestyleTyp.name
        case 1:
            let allergyType = allergiesData[indexPath.row]
            let isSelected = userProfile.allergicTypes.contains(allergyType)
            cell.accessoryType = isSelected ? .checkmark : .none
            cell.textLabel?.text = allergyType.name
        default:
            let ingredient = ingredients[indexPath.row]
            let isSelected = userProfile.dangerousIngredients.contains(ingredient)
            cell.accessoryType = isSelected ? .checkmark : .none
            cell.textLabel?.text = ingredient.description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerNames[section]
    }
}
