//
//  DetailMealViewController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import UIKit

class DetailMealViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsHeader: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var mealIconView: UIMealIconView!
    
    
    // MARK: - Instance Variable
    var receivedMeal: Meal!
    var mealCategorieName: String!
    
    let ingredientCtrl = IngredientController()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpDesign()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Help Methods
    func setUpUI() {
        self.title = mealCategorieName
        mealIconView.display(icons: receivedMeal.mealIconTypes)
        titleLabel.text = receivedMeal.name
        ingredientsTextView.attributedText = ingredientCtrl.highligtDangerousIngredients(in: receivedMeal)
    }
    
    func setUpDesign() {
        Mensaplan_2_0.setUpDesign(for: self.navigationController, for: self.tabBarController)
        view.backgroundColor = appColor.background
        titleLabel.textColor = appColor.text
        ingredientsHeader.textColor = appColor.text
    }
    
}
