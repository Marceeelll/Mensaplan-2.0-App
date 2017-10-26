//
//  AllergyTyp.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

enum Handicap: Int, Codable {
    case normal
    case nuts
    case gluten
    case vegetarian
    case vegan
    case mustard
    
    /**
     Enthält alle Allergien, bis auf `.normal`.
     */
    static let allAllergies: [Handicap] = [.nuts, .gluten, .vegetarian, .vegan, .mustard]
    static let lifestyle: [Handicap] = [.vegan, .vegetarian]
    static let allergies: [Handicap] = [.nuts, .gluten, .mustard]
    
    var name: String {
        switch self {
        case .normal: return "Normal"
        case .nuts: return "Nüsse"
        case .gluten: return "Gluten"
        case .vegetarian: return "Vegetarisch"
        case .vegan: return "Vegan"
        case .mustard: return "Senf"
        }
    }
}
