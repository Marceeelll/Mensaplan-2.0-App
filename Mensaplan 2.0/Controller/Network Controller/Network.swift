//
//  Network.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

class Network {
    var task: URLSessionDataTask!
    
    func getData(from url: URL, supervisor: NetworkSupervisor) {
        let session = URLSession.shared
        task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                supervisor.handleReceived(error: error!)
            } else {
                supervisor.handleReceived(data: data as AnyObject)
            }
        }
        task.resume()
    }
    
    func cancel() {
        task?.cancel()
        print("task?.cancel() - \(task.state)")
    }
}
