//
//  Ingredient.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

enum Ingredient {
    case i1
    case i2
    case i3
    case i4
    case i5
    case i6
    case i7
    case i8
    case i9
    case i10
    case i11
    case i12
    case i13
    case i14
    case i15
    case i16
    case i17
    case i18
    
    case iA1
    case iA2
    case iA3
    case iA4
    case iA5
    
    case iF
    case iI
    case iL
    case iM
    
    // Nüsse
    case iH1
    case iH2
    case iH3
    case iH4
    case iH5
    case iH6
    case iH7
    case iH8
    case iE
    case iH
    
    // Gluten
    case iA
    
    // Vegetarisch
    case iB
    case iD
    
    // Vegan
    case iC
    case iG
    case iN
    
    //Senf
    case iJ
    case iK
    
    
    
    
    static let allIngredients: [Ingredient] = [.i1, .i2, .i3, .i4, .i5, .i6, .i7, .i8, .i9, .i10,
                                               .i11, .i12, .i13, .i14, .i15, .i16, .i17, .i18,
                                               .iA1, iA2, iA3, iA4, iA5,
                                               .iF, .iI, .iL, .iM,
                                               .iH1, .iH2, .iH3, .iH4, .iH5, .iH6, .iH7, .iH8, .iE, .iH,
                                               .iA,
                                               .iB, .iD,
                                               .iC, .iG, .iN,
                                               .iJ, .iK]
    
    /**
     Inhaltstoffe Abküruzuung
     */
    static func getIngredientType(for shortSymbol: String) -> Ingredient {
        switch shortSymbol {
        case "1": return .i1
        case "2": return .i2
        case "3": return .i3
        case "4": return .i4
        case "5": return .i5
        case "6": return .i6
        case "7": return .i7
        case "8": return .i8
        case "9": return .i9
        case "10": return .i10
        case "11": return .i11
        case "12": return .i12
        case "13": return .i13
        case "14": return .i14
        case "15": return .i15
        case "16": return .i16
        case "17": return .i17
        case "18": return .i18
            
        case "a1": return .iA1
        case "a2": return .iA2
        case "a3": return .iA3
        case "a4": return .iA4
        case "a5": return .iA5
            
        case "h1": return .iH1
        case "h2": return .iH2
        case "h3": return .iH3
        case "h4": return .iH4
        case "h5": return .iH5
        case "h6": return .iH6
        case "h7": return .iH7
        case "h8": return .iH8
        case "e": return .iE
        case "h": return .iH
            
        case "a": return .iA
            
        case "b": return .iB
        case "d": return .iD
            
        case "c": return .iC
        case "g": return .iG
        case "n": return .iN
            
        case "j": return .iJ
        case "k": return .iK
            
        case "f": return .iF
        case "i": return .iI
        case "l": return .iL
        case "m": return .iM
            
        default: return .iA1 // TODO: ✅ Nicht der Beste Weg... 😅😬
        }
    }
    
    var description: String {
        switch self {
        case .i1: return "mit Farbstoff"
        case .i2: return "mit Konservierungsstoff"
        case .i3: return "mit Antioxidationsmittel"
        case .i4: return "mit Geschmacksverstärker"
        case .i5: return "geschwefelt"
        case .i6: return "geschwärzt"
        case .i7: return "gewachst"
        case .i8: return "mit Phosphat"
        case .i9: return "mit Süßungsmittel"
        case .i10: return "enthält eine Phenylalaninquelle"
        case .i11: return "kann bei übermässigem Verzehr abführend wirken"
        case .i12: return "coffeinhaltig"
        case .i13: return "chininhaltig"
        case .i14: return "mit Säuerungsmittel"
        case .i15: return "mit Verdickungsmittel"
        case .i16: return "Stabilisator"
        case .i17: return "mit Alkohol"
        case .i18: return "Säureregulator"
            
        case .iA1: return "Weizengluten"
        case .iA2: return "Roggengluten"
        case .iA3: return "Gerstengluten"
        case .iA4: return "Hafergluten"
        case .iA5: return "Dinkelgluten"
            
        case .iH1: return "Mandeln"
        case .iH2: return "Haselnüsse"
        case .iH3: return "Walnüsse"
        case .iH4: return "Cashewnüsse"
        case .iH5: return "Pecannüsse"
        case .iH6: return "Paranüsse"
        case .iH7: return "Pistazien"
        case .iH8: return "Macadamianüsse"
        case .iE: return "Erdnüsse und daraus hergestellte Erzeugnisse"
        case .iH: return "Schalenfrüchte"
            
        case .iA: return "Glutenhaltige Getreide"
            
        case .iB: return "Krebstiere und daraus hergestellte Erzeugnisse"
        case .iD: return "Fisch und daraus hergestellte Erzeugnisse"
            
        case .iC: return "Eier und daraus hergestellte Erzeugnisse"
        case .iG: return "Milch und daraus hergestellte Erzeugnisse"
        case .iN: return "Weichtiere und daraus hergestellte Erzeugnisse"
            
        case .iJ: return "Senf und daraus hergestellte Erzeugnisse"
        case .iK: return "Sesamsamen und daraus hergestellte Erzeugnisse"
            
        case .iF: return "Sojabohnen und daraus hergestellte Erzeugnisse"
        case .iI: return "Sellerie und daraus hergestellte Erzeugnisse"
        case .iL: return "Schwefeldioxid und Sulphite"
        case .iM: return "Lupinen und daraus hergestellte Erzeugnisse"
        }
    }
    
    static func get(handicaps: [Handicap]) -> [Ingredient] {
        var result: [Ingredient] = []
        for handicap in handicaps {
            let handicapIngredients = Ingredient.getIngredients(for: handicap)
            result.append(contentsOf: handicapIngredients)
        }
        return result
    }
    
    private static func getIngredients(for handicap: Handicap) -> [Ingredient] {
        var result: [Ingredient] = []
        switch handicap {
        case .normal: result = []
        case .nuts: result = [.iH1, .iH2, .iH3, .iH4, .iH5, .iH6, .iH7, .iH8, .iE, .iH]
        case .gluten: result = [.iA]
        case .vegan: result = [.iC, .iG]
            fallthrough
        case .vegetarian: result.append(contentsOf: [.iB, .iD, .iN])
        case .mustard: result = [.iJ, .iK]
        }
        return result
    }
}
