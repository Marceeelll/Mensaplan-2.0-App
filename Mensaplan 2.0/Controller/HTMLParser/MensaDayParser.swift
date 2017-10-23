//
//  MensaDayParser.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 17.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

struct MensaDayParser {
    func parse(_ data: String, for date: Date) -> MensaDay {
        // Vorgehensweise
        // 1. Unnötige Informationen die am Anfang stehen abschneiden
        // 2. Split nach Hauptkategorien
        //   2.1 Meal Split, der Hauptgerichte
        //   2.2 In den Hauptgategorien befinden sich teils unter Kategorien, diese rausholen
        // 3. Split der Unterkategorien
        // 4. Meal Split, die einzelnen Speisen in der Kategorie raus holen
        //   4.1 Meal-Name
        //   4.2 Meal-Attributes
        //   4.3 Meal-Price
        //   4.4 Meal-Ingredients
        
        var result = MensaDay(date: date, mealCategories: [])
        var mealCategories: [MealCategorie]? = []
        
        var htmlString = data
        
        // START 1.
        var splitString = "<div class=\"container\" id=\"content\">"
        var splitResults: [String] = []
        splitResults = htmlString.components(separatedBy: splitString)
        
        htmlString = splitResults.last!
        // END 1. --> Unnötige Informationen wurden aus dem HTML-String entfernt
        
        // START 2.
        splitString = "<div class=\"tx-bwrkspeiseplan__bar tx-bwrkspeiseplan__"
        splitResults = htmlString.components(separatedBy: splitString)
        
        
        for mainDishRecord in splitResults {
            if let mainDishName = splitMainCategorieName(in: mainDishRecord) {
                var mealCategorie = MealCategorie(name: mainDishName)
                
                // START 2.1
                splitString = "<tr class=\"\"> "//"tx-bwrkspeiseplan__table-meals"
                splitResults = mainDishRecord.components(separatedBy: splitString)
                
                for result in splitResults {
                    // START 4
                    if let meal = splitMeal(in: result) {
                        mealCategorie.meals.append(meal)
                    }
                    // END 4. --> Meal-Daten gesammelt und hinzugefügt
                    
                    // START 3
                    if containsSideDishesCategorieName(in: result) {
                        if let sideDisheCategorieName = splitSideDishesCategorieName(in: result) {
                            mealCategories!.append(mealCategorie)
                            mealCategorie = MealCategorie(name: sideDisheCategorieName)
                        }
                    }
                    // END 3. --> Unterkategorie gefunden und hinzugefügt
                }
                
                mealCategories!.append(mealCategorie)
            }
        }
        
        // END 2. --> Die Hauptkategorien wurden gespiltet
        
        
        // Zusammen pflegen der Daten
        if mealCategories!.count == 0 {
            result.mealCategories = nil
        } else if mealCategories?[0].meals.count == 0 {
            result.mealCategories = nil
        } else {
            result.mealCategories = mealCategories
        }
        
        return result
    }
    
    /**
     Gitb den Namen des als nächstes kommenden Hauptgericht zurück.
     */
    private func splitMainCategorieName(in string: String) -> String? {
        if let result = string.slice(from: "<h3>", to: "</h3>") {
            if doesntContainsForbiddenSubstrings(str: result) {
                return result
            }
        }
        return nil
    }
    
    private func splitMeal(in string: String) -> Meal? {
        guard let mealName = splitMealName(in: string)
            else { return nil }
        //        print(mealName)
        
        guard let mealPrice = splitMealPrice(in: string)
            else { return nil }
        //        print("\t\(mealPrice)")
        
        guard let mealAttributes = splitMealAttributes(in: string)
            else { return nil }
        //        print("\t\(mealAttributes)")
        
        guard let mealIngredients = splitMealIngredients(in: string)
            else { return nil }
        //        print("\t\(mealIngredients)")
        
        let meal = Meal(name: mealName, attributes: mealAttributes, price: mealPrice, ingredients: mealIngredients)
        return meal
    }
    
    private func splitMealName(in string: String) -> String? {
        // TODO: ✅ hier steht zu viel doppelter Code
        if string.contains("<sup>") {
            var mealName = string.slice(from: "<td>", to: "<sup>")
            mealName = mealName?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return mealName
        } else {
            // wenn die Mahlzeit keine Inhaltsstoffe beinhaltet
            // Achtung: Unterschied zwischen HTML von heute und morgen
            
            // Meal-Name split für den heutigen Tag
            if var mealName = string.slice(from: "<td>", to: "<a href=") {
                mealName = mealName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                return mealName
            }
            
            // Meal-Name split für die nächsten Tage
            var mealName = string.slice(from: "<td>", to: "</td>")
            mealName = mealName?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return mealName
        }
    }
    
    private func splitMealIngredients(in string: String) -> [String]? {
        if string.contains("<sup>") && string.contains("</sup>") {
            if let mealIngredientsString = string.slice(from: "<sup>(", to: ")</sup>") {
                var mealIngredients = mealIngredientsString.components(separatedBy: ",")
                for i in 0..<mealIngredients.count {
                    mealIngredients[i] = mealIngredients[i].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                }
                return mealIngredients
            }
        } else {
            return []
        }
        return nil
    }
    
    private func splitMealPrice(in string: String) -> Price? {
        var splittedPrices = string.components(separatedBy: "<span class=")
        splittedPrices.removeFirst()
        var prices: [Double] = []
        for priceHTMLString in splittedPrices {
            if var priceString = priceHTMLString.slice(from: "&euro; ", to: "</span>") {
                priceString = priceString.replacingOccurrences(of: ",", with: ".")
                if let price = Double(priceString) {
                    prices.append(price)
                }
            }
        }
        if prices.count == PriceLevel.allPriceLevels.count {
            let price = Price(student: prices[0], servant: prices[1], guest: prices[2], hföd: prices[3])
            return price
        }
        return nil
    }
    
    private func splitMealAttributes(in string: String) -> [String]? {
        var splittedAttributes: [String] = []
        if string.contains("<span class=\"icon__") {
            splittedAttributes = string.components(separatedBy: "<span class=\"icon__") // sonderfall bei vegetarisch<--(durchgestrichen)
        } else {
            splittedAttributes = string.components(separatedBy: "<i class=\"icon")
        }
        // 🚨 Bug: Bei dem letzten Element von allen, wird das Attribute nicht richtig ausgelesen
        //         Der Grund ist, dass in der nachfolgende Zeile, das erste Element gelöscht wird, was auch bei allen anderen Meals korrekt ist
        //         Allerdings befindet sich bei der letzten Speise die Informationen darin
        splittedAttributes.removeFirst()
        var attributes: [String] = []
        for attributeHTMLString in splittedAttributes {
            if !attributeHTMLString.contains("Alle Ansprechpartner") { // TODO: ✅ Nicht schön gemacht...
                if let attribute = attributeHTMLString.slice(from: "title=\"", to: "\">") {
                    attributes.append(attribute)
                }
            }
        }
        // TODO: ✅ hier wird kein nil zurück gegeben, sonder immer ein leeres array! überlegen, ob das sinnvol ist! Wenn nicht nil zurück geben, wo auch immer
        return attributes
    }
    
    private func containsSideDishesCategorieName(in string: String) -> Bool {
        let containsCategorieName = string.contains("<span>") && string.contains("</span>")
        return containsCategorieName
    }
    
    private func splitSideDishesCategorieName(in string: String) -> String? {
        var splittedSideDishes = string.components(separatedBy: "<i class=\"fa fa-caret-right\">")
        splittedSideDishes.removeFirst()
        if let sideDisheCategorieName = splittedSideDishes.last?.slice(from: "<span>", to: "</span>") {
            return sideDisheCategorieName
        }
        return nil
    }
    
    private var arrayOfForbiddenSubstrings = ["<div", "class", "="]
    private func doesntContainsForbiddenSubstrings(str: String) -> Bool {
        for forbiddenSubstring in arrayOfForbiddenSubstrings {
            if str.contains(forbiddenSubstring) {
                return false
            }
        }
        return true
    }
}
