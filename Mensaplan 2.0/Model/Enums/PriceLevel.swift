//
//  PriceLevel.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 17.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import Foundation

enum PriceLevel: Int, Codable {
    case student
    case servant
    case guest
    case hföd
    
    static let allPriceLevels = [PriceLevel.student, .servant, .guest, .hföd]
    
    var priceLevelName: String {
        switch self {
        case .student: return "Student"
        case .servant: return "Bedienstete"
        case .guest: return "Gäste"
        case .hföd: return "Sondertarif"
        }
    }
}
