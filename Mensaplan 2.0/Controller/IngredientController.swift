//
//  IngredientController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 22.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class IngredientController {
    let dangerousAttributes : [NSAttributedString.Key : Any] = [.foregroundColor:appColor.dangerousText]
    let notDangerousAttributes : [NSAttributedString.Key : Any] = [.foregroundColor:appColor.text]
    
    func highligtDangerousIngredients(in meal: Meal) -> NSAttributedString {
        let result = NSMutableAttributedString()
        for shortIngredientString in meal.ingredients {
            let mealIngredient = Ingredient.getIngredientType(for: shortIngredientString)
            let isDangerous = userProfile.dangerousIngredients.contains(mealIngredient)
            let attributes = isDangerous ? dangerousAttributes : notDangerousAttributes
            let ingredientDescriptionFormatted = "• \(mealIngredient.description)\n"
            let longIngredientString = NSAttributedString(string: ingredientDescriptionFormatted, attributes: attributes)
            result.append(longIngredientString)
        }
        return result
    }
    
    func containsDangerousIngredients(in meal: Meal) -> Bool {
        for shortIngredientString in meal.ingredients {
            let mealIngredient = Ingredient.getIngredientType(for: shortIngredientString)
            let isDangerous = userProfile.dangerousIngredients.contains(mealIngredient)
            if isDangerous {
                return true
            }
        }
        return false
    }
}
