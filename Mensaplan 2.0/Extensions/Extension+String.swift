//
//  Extension+String.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 18.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

extension String {
    /**
     Schneidet ab dem Ende von `startString` bist vor `endString` ab.
     
     ````
     var str = "Marcel Hagmann"
     str.slice(from: "ar", to: "ma") --> "cel Hag"
     ````
     */
    func slice(from startString: String, to endString: String) -> String? {
        if let foundStartRange = self.range(of: startString), let foundEndRange = self.range(of: endString) {
            return String(self[foundStartRange.upperBound..<foundEndRange.lowerBound])
        }
        return nil
    }
    
    /**
     Schneidet bis vor `endString` ab.
     
     ````
     var str = "Marcel Hagmann"
     str.slice(to endString: "ma") --> "Marcel Hag"
     ````
     */
    func slice(to endString: String) -> String? {
        if let foundRange = self.range(of: endString) {
            return String(self[self.startIndex..<foundRange.lowerBound])
        }
        return nil
    }
    
    /**
     Schneidet ab dem Ende von `startString` ab.
     
     ````
     var str = "Marcel Hagmann"
     str.slice(from startString: "rc") --> "el Hagmann"
     ````
     */
    func slice(from startString: String) -> String? {
        if let foundStartRange = self.range(of: startString) {
            return String(self[foundStartRange.upperBound..<self.endIndex])
        }
        return nil
    }
}
