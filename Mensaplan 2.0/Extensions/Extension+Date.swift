//
//  Extension+Date.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

extension Date {
    var germanDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd.MM.yyyy"
        return formatter.string(from: self)
    }
    
    static func getYesterday() -> Date? {
        let yesterday = getDate(in: -1)
        return yesterday
    }
    
    static func getYesterdayMidnight() -> Date? {
        let yesterdayMidnight = getDateAtMidnight(in: -1)
        return yesterdayMidnight
    }
    
    static func getTomorrow() -> Date? {
        let tomorrow = getDate(in: 1)
        return tomorrow
    }
    
    static func getTomorrowMidnight() -> Date? {
        let tomorrowMidnight = getDateAtMidnight(in: 1)
        return tomorrowMidnight
    }
    
    static func getDate(in days: Int) -> Date? {
        let today = Date()
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = days
        let tomorrow = calendar.date(byAdding: components, to: today)
        return tomorrow
    }
    
    static func getDateAtMidnight(in days: Int) -> Date? {
        if let tomorrow = getDate(in: days) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let tomorrowString = dateFormatter.string(from: tomorrow)
            let tomorrowMidnight = dateFormatter.date(from: tomorrowString)
            return tomorrowMidnight
        }
        return nil
    }
}
