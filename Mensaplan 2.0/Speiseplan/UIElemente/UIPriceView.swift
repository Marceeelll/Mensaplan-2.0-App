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
    
    var price: Price! = nil
    
    func set(price: Price) {
        setPriceLabelIfNeeded()
        self.price = price
        priceLabel.text = price.description(for: userProfile.priceLevel)
    }
    
    func setDetail() {
        setPriceLabelIfNeeded()
        priceLabel.text = price.longDescription()
    }
    
    private func setPriceLabelIfNeeded() {
        if priceLabel != nil {
            priceLabel.removeFromSuperview()
        }
        
        let priceShape = CAShapeLayer()
        priceShape.bounds = self.frame
        priceShape.position = self.center
        priceShape.path = UIBezierPath(roundedRect: self.bounds,
                                       byRoundingCorners: [UIRectCorner.topLeft],
                                       cornerRadii: CGSize(width: self.bounds.height/2, height: self.bounds.width/2)).cgPath
        
        self.layer.mask = priceShape
        
        priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        priceLabel.font = UIFont(name: "Helvetica", size: 14)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.textColor = UIColor.white
        priceLabel.textAlignment = .center
        addSubview(priceLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let speiseplanTVCell = self.superview?.superview as? UISpeiseplanTableViewMealCell {
            let didExpand = speiseplanTVCell.expandOrShrinkPriceView()
            if didExpand {
                setDetail()
            } else {
                set(price: price)
            }
        }
    }
}
