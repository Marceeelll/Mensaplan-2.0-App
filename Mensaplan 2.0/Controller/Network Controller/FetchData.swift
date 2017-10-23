//
//  FetchData.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

class FetchData : NSObject, NetworkSupervisor {
    var network = Network()
    
    var id: Int!
    var delegate: FetchDataDelegate?
    var date: Date!
    
    func fetchData(for url: URL) {
        network.getData(from: url, supervisor: self)
    }
    
    func handleReceivedData(data: AnyObject) {
        print("Downloaded Data")
        var mensaDay: MensaDay! // 🚨 gefähliches unwrapped optional
        if let d = data as? Data {
            if let htmlString = String(data: d, encoding: String.Encoding.utf8) {
                let mensaHTMLParser = MensaDayParser()
                mensaDay = mensaHTMLParser.parse(htmlString, for: date)
            }
        }
        delegate?.didFinishedDataProcessing(for: id, with: mensaDay)
    }
    
    func cancel() {
        network.cancel()
    }
}
