//
//  SpeiseplanTableViewDelegate.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class SpeiseplanTableViewDelegate : NSObject, UITableViewDelegate {
    weak var viewCtrl: UIViewController!
    private(set) var selectedMeal: Meal!
    private(set) var selectedMealCategorieName: String!
    
    init(viewCtrl: UIViewController) {
        self.viewCtrl = viewCtrl
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dSource = tableView.dataSource as! SpeiseplanTableViewDataSource
        if dSource.isDateCell(indexPath) {
            return 45.0
        } else if dSource.isLegend(section: indexPath.section) {
            return 270.0
        } else {
            return 70.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dSource = tableView.dataSource as! SpeiseplanTableViewDataSource
        if !dSource.dayContainsNoMealData() && !dSource.isLegend(section: indexPath.section) && !dSource.isDateCell(indexPath) {
            selectedMeal = dSource.getMeal(at: indexPath)
            selectedMealCategorieName = dSource.getMealCategorieName(at: indexPath.section)
            viewCtrl.performSegue(withIdentifier: storyboardSegueIDSpeiseplanToMealDetail, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header: UITableViewHeaderFooterView = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = appColor.tableViewHeader
            header.textLabel?.textColor = appColor.tableViewHeaderText
        }
    }
    
}
