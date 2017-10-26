//
//  Meal.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 17.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import Foundation

struct Meal: Codable {
    var name: String
    /**
     Aus den Attributen (vegan, hausgemacht, wild, ...) wird das Icon generiert.
     */
    var attributes: [String]
    
    /**
     Generiert aus den `attributes` die dazugehörigen `MealIconTypes`
     */
    var mealIconTypes: [UIMealIconView.MealIconType] {
        var mealIcons: [UIMealIconView.MealIconType] = []
        for mealIconName in attributes {
            let mealIcon = UIMealIconView.MealIconType.getMealIconType(for: mealIconName)
            mealIcons.append(mealIcon)
        }
        if mealIcons.count == 0 {
            mealIcons.append(.error)
        }
        return mealIcons
    }
    
    var price: Price
    /**
     Die abkürzungen (a1, c, g, h, ...) der Inhaltsstoffe, die sich in dem `Meal` befinden.
     
     */
    var ingredients: [String]
}
