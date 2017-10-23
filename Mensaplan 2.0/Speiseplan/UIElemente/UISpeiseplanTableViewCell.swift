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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dangerousIngredientsView.makeViewRound()
        dangerousIngredientsView.backgroundColor = appColor.warningOfIngredients
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(_ meal: Meal?) {
        if let meal = meal {
            mealTitleLabel.text = meal.name
            priceView.set(price: meal.price)
            mealIconView.display(icons: meal.mealIconTypes)
        }
    }

}
