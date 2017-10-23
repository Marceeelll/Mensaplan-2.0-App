//
//  MensaSelectionDelegate.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

protocol MensaSelectionDelegate {
    func receive(selection indexPath: IndexPath, canteen: Canteen)
}
