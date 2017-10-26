//
//  MensaData.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

class MensaData {
    private var model = MensaDataSingleton.sharedInstance
    
    var mensaDays: [MensaDay] {
        return model.mensaDays
    }
    
    var lastUpdate: Date? {
        return model.lastUpdate
    }
    
    func getMensaDay(for index: Int) -> MensaDay {
        if mensaDays.count == 0 {
            return MensaDay(date: Date(), mealCategories: nil)
        }
        return mensaDays[index]
    }
    
    var numberOfMensaDays: Int {
        return mensaDays.count
    }
    
    func append(mensaDay: MensaDay) {
        model.mensaDays.append(mensaDay)
    }
    
    func set(mensaDays: [MensaDay]) {
        model.mensaDays = mensaDays
    }
    
    func sortMensaDays() {
        model.mensaDays = mensaDays.sorted(by: { mensaDay1, mensaDay2 in
            return mensaDay1.date.compare(mensaDay2.date) == ComparisonResult.orderedAscending
        })
    }
    
    func didUpdate() {
        model.lastUpdate = Date()
    }
    
    func reset() {
        model.mensaDays = []
    }
    
    func deleteOldData() {
        let today = Date()
        for index in (0..<mensaDays.count).reversed() {
            let mensaDay = mensaDays[index]
            if mensaDay.date < today {
                model.mensaDays.remove(at: index)
            }
        }
    }
    
    
}


fileprivate class MensaDataSingleton {
    private init() {}
    static var sharedInstance = MensaDataSingleton()
    
    var mensaDays: [MensaDay] = []
    var lastUpdate: Date?
}
