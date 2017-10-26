//
//  SpeiseplanTableViewCell.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 18.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class UISpeiseplanTableViewMealCell: UITableViewCell {
    @IBOutlet weak var mealIconView: UIMealIconView!
    @IBOutlet weak var priceView: UIPriceView!
    @IBOutlet weak var dangerousIngredientsView: UIView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var priceViewLeftEdgeConstraint: NSLayoutConstraint!
    var showDetailPriceView: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dangerousIngredientsView.makeViewRound()
        dangerousIngredientsView.backgroundColor = appColor.warningOfIngredients
        priceView.backgroundColor = appColor.priceView
        mealTitleLabel.textColor = appColor.text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(_ meal: Meal?) {
        if let meal = meal {
            mealTitleLabel.text = meal.name
            mealIconView.display(icons: meal.mealIconTypes)
            if showDetailPriceView {
                priceView.setDetail()
            } else {
                priceView.set(price: meal.price)
            }
        }
    }
    
    /**
     Returns `true` wenn die PriceView vergrößert wurde
     */
    func expandOrShrinkPriceView() -> Bool {
        if let tableView = superview as? UITableView {
            if let tvDataSource = tableView.dataSource as? SpeiseplanTableViewDataSource {
                if let indexPath = tableView.indexPath(for: self) {
                    if priceViewLeftEdgeConstraint.constant == 5 {
                        showNormalPriceView()
                        tvDataSource.removeExpandablePriceView(at: indexPath)
                        return false
                    } else {
                        showBigPriceView()
                        tvDataSource.appendExpandabledPriceView(at: indexPath)
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func showBigPriceView(_ animated: Bool = true) {
        showDetailPriceView = true
        priceViewLeftEdgeConstraint.constant = 5
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.layoutIfNeeded()
            })
        } else {
            self.layoutIfNeeded()
        }
    }
    
    func showNormalPriceView(_ animated: Bool = true) {
        showDetailPriceView = false
        priceViewLeftEdgeConstraint.constant = 160
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.layoutIfNeeded()
            })
        } else {
            self.layoutIfNeeded()
        }
    }

}
