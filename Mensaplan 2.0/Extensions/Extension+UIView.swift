//
//  Extension+UIView.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Rundet die Ecken der View so stark ab, dass ein Kreis entsteht.
     
     View sollte rund sein.
     */
    func makeViewRound() {
        self.layer.cornerRadius = self.frame.width/2
    }
}
