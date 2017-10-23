//
//  UIStepSlider.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class UIStepSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStepSlider()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpStepSlider()
    }
    
    func setUpStepSlider() {
        addTarget(self, action: #selector(valueHasChanged), for: .valueChanged)
    }
    
    @objc func valueHasChanged() {
        let newValue = Float(Int(value))
        value = newValue
        self.setValue(value, animated: false)
    }

}
