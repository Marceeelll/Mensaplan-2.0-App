//
//  UISpeiseplanTableViewLegendCell.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 23.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class UISpeiseplanTableViewLegendCell: UITableViewCell {
    @IBOutlet var mealIcons: [UIMealIconView]!
    @IBOutlet var mealLabels: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI() {
        // TODO: ✅ nicht so toll der Zugriff ?!?!?!!?!!!
        for index in 0..<UIMealIconView.MealIconType.allMeals.count {
            let mealType = UIMealIconView.MealIconType.allMeals[index]
            let mealIcon = mealIcons[index]
            let mealLabel = mealLabels[index]
            mealIcon.display(icons: [mealType])
            mealLabel.adjustsFontSizeToFitWidth = true
            mealLabel.text = mealType.name
            mealLabel.textColor = appColor.text
        }
        self.backgroundColor = appColor.background
    }

}
