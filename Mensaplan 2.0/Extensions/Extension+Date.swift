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
}
