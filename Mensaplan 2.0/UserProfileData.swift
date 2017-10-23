//
//  UserProfileData.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 22.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

class UserProfileData {
    private var model = UserProfileDataSingleton.sharedInstance
    
    /**
     Beinhaltet die kurz
     */
    var dangerousIngredients: [Ingredient] {
        return model.dangerousIngredients
    }
    
    var allergicTypes: [Handicap] {
        return model.allergicTypes
    }
    
    var lifestyle: [Handicap] {
        return model.lifestyle
    }
    
    var priceLevel: PriceLevel {
        return model.priceLevel
    }
    
    var numberOfDaysToDownload: Int {
        return model.numberOfDaysToDownload
    }
    
    func set(new priceLevel: PriceLevel) {
        model.priceLevel = priceLevel
    }
    
    func set(new canteen: Canteen) {
        model.canteen = canteen
    }
    
    var canteen: Canteen {
        return model.canteen
    }
    
    func addOrRemove(ingredient: Ingredient) {
        if let index = dangerousIngredients.index(of: ingredient) {
            model.dangerousIngredients.remove(at: index)
        } else {
            model.dangerousIngredients.append(ingredient)
        }
    }
    
    func add(ingredients: [Ingredient]) {
        for ingredient in ingredients {
            if !dangerousIngredients.contains(ingredient) {
                model.dangerousIngredients.append(ingredient)
            }
        }
    }
    
    func remove(ingredients: [Ingredient]) {
        for ingredient in ingredients {
            if let index = dangerousIngredients.index(of: ingredient) {
                model.dangerousIngredients.remove(at: index)
            }
        }
    }
    
    func addOrRemove(lifestyle: Handicap) {
        if let index = self.lifestyle.index(of: lifestyle) {
            model.lifestyle.remove(at: index)
        } else {
            model.lifestyle.append(lifestyle)
        }
    }
    
    func remove(lifestyle: Handicap) {
        if let index = self.lifestyle.index(of: lifestyle) {
            model.lifestyle.remove(at: index)
        }
    }
    
    func addOrRemove(allergy: Handicap) {
        if let index = self.allergicTypes.index(of: allergy) {
            model.allergicTypes.remove(at: index)
        } else {
            model.allergicTypes.append(allergy)
        }
    }
    
    func set(numberOfDaysToDownload: Int) {
        model.numberOfDaysToDownload = numberOfDaysToDownload
    }
}


fileprivate class UserProfileDataSingleton {
    static var sharedInstance = UserProfileDataSingleton()
    private init() {}
    
    var allergicTypes: [Handicap] = []
    var lifestyle: [Handicap] = []
    var dangerousIngredients: [Ingredient] = []
    var priceLevel: PriceLevel = .student
    var numberOfDaysToDownload: Int = 7
    var canteen = Canteen.Hof
}
