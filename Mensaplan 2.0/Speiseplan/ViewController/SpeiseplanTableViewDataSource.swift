//
//  SpeiseplanTableViewDataSource.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class SpeiseplanTableViewDataSource : NSObject, UITableViewDataSource {
    var data: MensaDay {
        didSet {
            expandedPriceViewCells = []
        }
    }
    let numberOfExtraCells: Int = 2 // Datum, Legende
    private var expandedPriceViewCells: [IndexPath] = []
    let ingredientCtrl = IngredientController()
    
    override init() {
        data = mensaData.getMensaDay(for: currentIndex)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dayContainsNoMealData() {
            return 2 // one for the date + one for the Error
        } else {
            return data.mealCategories!.count + numberOfExtraCells
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.mealCategories == nil {
            return 1
        } else {
            if section == 0 {
                return 1
            } else if isLegend(section: section) {
                return 1
            } else {
                let sectionConsiderDate = getSectionConsiderDate(at: section)
                return data.mealCategories![sectionConsiderDate].meals.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isDateCell(indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! UISpeiseplanTableViewDateCell
            cell.dateLabel.text = data.date.germanDate
            cell.backgroundColor = appColor.background
            return cell
        }
        
        if isLegend(section: indexPath.section) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "legendCell", for: indexPath)  as! UISpeiseplanTableViewLegendCell
            cell.backgroundColor = appColor.background
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! UISpeiseplanTableViewMealCell
        cell.backgroundColor = appColor.background
        
        if data.mealCategories == nil {
            let errorMeal = Meal(name: "Am gewählten Tag sind keine Gerichte verfügbar",
                                 attributes: [],
                                 price: Price(student: 0, servant: 0, guest: 0, hföd: 0),
                                 ingredients: [])
            cell.display(errorMeal)
            cell.dangerousIngredientsView.isHidden = true
        } else {
            let meal = getMeal(at: indexPath)
            if expandedPriceViewCells.contains(indexPath) {
                cell.showBigPriceView(false)
            } else {
                cell.showNormalPriceView(false)
            }
            cell.display(meal)
            cell.dangerousIngredientsView.isHidden = !ingredientCtrl.containsDangerousIngredients(in: meal)
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isLegend(section: section) {
            return "Legende"
        } else {
            return getMealCategorieName(at: section)
        }
    }
    
    func getMeal(at indexPath: IndexPath) -> Meal {
        let sectionConsiderDate = getSectionConsiderDate(at: indexPath.section)
        return data.mealCategories![sectionConsiderDate].meals[indexPath.row]
    }
    
    func isLegend(section: Int) -> Bool {
        if let numberOfMealCategories = data.mealCategories?.count {
            return numberOfMealCategories + numberOfExtraCells - 1 == section
        } else {
            return false
        }
    }
    
    /**
     Gibt `true` zurück, wenn an dem Tag keine Daten vorhanden sind.
     
     An so einem Tag wird ein Error-Meal angezeigt
     */
    func dayContainsNoMealData() -> Bool {
        return data.mealCategories == nil
    }
    
    func getMealCategorieName(at section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            let sectionConsiderDate = getSectionConsiderDate(at: section)
            return data.mealCategories?[sectionConsiderDate].name
        }
    }
    
    func isDateCell(_ indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row == 0
    }
    
    func getSectionConsiderDate(at section: Int) -> Int {
        let sectionConsiderDate = section - 1 // Weil Date an erster Stelle eingeschoben ist
        return sectionConsiderDate
    }
    
    func reloadCurrentMensaDay() {
        data = mensaData.getMensaDay(for: currentIndex)
    }
    
    
    
    // MARK: - Switch between different days
    let mensaData = MensaData()
    private var currentIndex: Int = 0
    
    func resetCurrentIndexToZero() {
        currentIndex = 0
        data = mensaData.getMensaDay(for: currentIndex)
    }
    
    func hasNextMensaDay() -> Bool {
        print("currentIndex: \(currentIndex) - \(mensaData.numberOfMensaDays)")
        return currentIndex < mensaData.numberOfMensaDays - 1
    }
    
    func hasPreviousMensaDay() -> Bool {
        print("currentIndex: \(currentIndex)")
        return currentIndex > 0
    }
    
    func nextMensaDay() {
        if hasNextMensaDay() {
            currentIndex += 1
            data = mensaData.getMensaDay(for: currentIndex)
            print("currentIndex: \(currentIndex)")
        }
    }
    
    func previousMensaDay() {
        if hasPreviousMensaDay() {
            currentIndex -= 1
            data = mensaData.getMensaDay(for: currentIndex)
            print("currentIndex: \(currentIndex)")
        }
    }
    
    
    // MARK: - Expandable Price View Handling
    func appendExpandabledPriceView(at indexPath: IndexPath) {
        expandedPriceViewCells.append(indexPath)
    }
    
    func removeExpandablePriceView(at indexPath: IndexPath) {
        for index in 0..<expandedPriceViewCells.count {
            if indexPath == expandedPriceViewCells[index] {
                expandedPriceViewCells.remove(at: index)
                break
            }
        }
    }
}








