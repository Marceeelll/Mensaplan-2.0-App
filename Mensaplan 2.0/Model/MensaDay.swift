//
//  MensaDay.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 17.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import Foundation

/**
 Verwaltet den Tag und die dazugehören `MealCategories` die es an dem Tag gibt.
 */
struct MensaDay: Codable {
    var date: Date
    var mealCategories: [MealCategorie]?
}
