//
//  UIPriceView.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 18.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class UIPriceView : UIView {
    private var priceLabel: UILabel!
    
    func set(price: Price) {
        setPriceLabelIfNeeded()
        priceLabel.text = price.description(for: userProfile.priceLevel)
    }
    
    private func setPriceLabelIfNeeded() {
        if priceLabel == nil {
            let priceShape = CAShapeLayer()
            priceShape.bounds = self.frame
            priceShape.position = self.center
            priceShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.topLeft], cornerRadii: CGSize(width: self.bounds.height/2, height: self.bounds.height/2)).cgPath
            
            self.layer.mask = priceShape
            
            priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            priceLabel.font = UIFont(name: "Helvetica", size: 14)
            priceLabel.adjustsFontSizeToFitWidth = true
            priceLabel.textColor = UIColor.white
            priceLabel.textAlignment = .center
            addSubview(priceLabel)
        }
    }
}
