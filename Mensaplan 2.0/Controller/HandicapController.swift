//
//  HandicapController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 22.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

class HandicapController {
    func add(handicap: Handicap) {
        if Handicap.lifestyle.contains(handicap) {
            var handicapIngredients: [Ingredient] = []
            
            if handicap == .vegan {
                handicapIngredients = Ingredient.get(handicaps: [handicap, .vegan])
            } else {
                handicapIngredients = Ingredient.get(handicaps: [handicap])
            }
            
            if userProfile.lifestyle.contains(handicap) {
                if handicap == .vegan {
                    var removeHandicap = Set(handicapIngredients)
                    let vegetarianIngredients = Ingredient.get(handicaps: [.vegetarian])
                    for vegetarianIngredient in vegetarianIngredients {
                        removeHandicap.remove(vegetarianIngredient)
                    }
                    userProfile.remove(ingredients: Array(removeHandicap))
                } else {
                    userProfile.remove(ingredients: handicapIngredients)
                }
            } else {
                userProfile.add(ingredients: handicapIngredients)
            }
            
            if handicap == .vegan {
                userProfile.addOrRemove(lifestyle: .vegan)
                
                if !userProfile.lifestyle.contains(.vegetarian) {
                    userProfile.addOrRemove(lifestyle: .vegetarian)
                }
                if !userProfile.lifestyle.contains(.vegetarian) {
                    userProfile.remove(lifestyle: .vegan)
                }
            } else if handicap == .vegetarian {
                userProfile.addOrRemove(lifestyle: handicap)
                
                if !userProfile.lifestyle.contains(.vegetarian) {
                    userProfile.remove(lifestyle: .vegan)
                }
            } else { // wird aktuell nie ausgeführt, da nur .vegan & .vegetarian vorhanden sind. Vorhanden falls mehr kommen.
                userProfile.addOrRemove(lifestyle: handicap)
            }
        } else if Handicap.allergies.contains(handicap) {
            let handicapIngredients = Ingredient.get(handicaps: [handicap])
            if userProfile.allergicTypes.contains(handicap) {
                userProfile.remove(ingredients: handicapIngredients)
            } else {
                userProfile.add(ingredients: handicapIngredients)
            }
            userProfile.addOrRemove(allergy: handicap)
        }
    }
}
