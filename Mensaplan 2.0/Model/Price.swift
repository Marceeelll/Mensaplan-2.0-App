//
//  Price.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 17.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import Foundation

struct Price: Codable {
    var student: Double
    var servant: Double
    var guest: Double
    var hföd: Double
    
    /**
     Returned den Preis für das übergebene `priceLevel` mit zwei Nachkommastellen **12.00€**
     */
    func description(for priceLevel: PriceLevel) -> String {
        var price: Double = 0.0
        switch priceLevel {
        case .student: price = student
        case .servant: price = servant
        case .guest: price = guest
        case .hföd: price = hföd
        }
        let priceFormat = String(format: "%.2f€", arguments: [price])
        let priceDescription = "\(priceLevel.priceLevelName): \(priceFormat)"
        return priceDescription
    }
    
    func longDescription() -> String {
        let plStudent = PriceLevel.student
        let plServant = PriceLevel.servant
        let plGuest = PriceLevel.guest
        let plHföd = PriceLevel.hföd
        let longPriceDescription = String(format: "%@: %.2f€ | %@: %.2f€ | %@: %.2f€ | %@: %.2f€", arguments: [plStudent.priceLevelName, student,
                                                                                                                         plServant.priceLevelName, servant,
                                                                                                                         plGuest.priceLevelName, guest,
                                                                                                                         plHföd.priceLevelName, hföd])
        return longPriceDescription
    }
}
