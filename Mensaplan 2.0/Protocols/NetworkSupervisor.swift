//
//  NetworkSupervisor.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

protocol NetworkSupervisor {
    func handleReceived(data: AnyObject)
    func handleReceived(error: Error)
}
