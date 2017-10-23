//
//  MealCategorie.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 17.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import Foundation

/**
 Eine `MealCategorie` ist eine Unterteilung der Gerichte in *Hauptspeise, Nachspeise, Beilage, etc.*
 */
struct MealCategorie {
    var name: String
    var meals: [Meal]
    
    init(name: String) {
        self.init(name: name, meals: [])
    }
    
    init(name: String, meals: [Meal]) {
        self.name = name
        self.meals = meals
    }
}
