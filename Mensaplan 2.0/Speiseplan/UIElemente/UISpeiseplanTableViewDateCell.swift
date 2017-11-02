//
//  UISpeiseplanTableViewDateCell.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 22.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class UISpeiseplanTableViewDateCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var previousMensaDayButton: UIButton!
    @IBOutlet weak var nextMensaDayButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI() {
        dateLabel.textColor = appColor.text
        previousMensaDayButton.setTitleColor(appColor.text, for: .normal)
        previousMensaDayButton.setTitleColor(UIColor.lightGray, for: .disabled)
        nextMensaDayButton.setTitleColor(appColor.text, for: .normal)
        nextMensaDayButton.setTitleColor(UIColor.lightGray, for: .disabled)
        self.backgroundColor = appColor.background
    }
    
    @IBAction func showNextDayAction(_ sender: UIButton) {
        // iPhone
        if let tableView = self.superview as? UITableView {
            let dSource = tableView.dataSource as! SpeiseplanTableViewDataSource
            dSource.nextMensaDay()
            displayStepperButtonsIfNeeded()
            tableView.reloadData()
        }
        // iPad
        if let tableView = self.superview?.superview as? UITableView {
            let dSource = tableView.dataSource as! SpeiseplanTableViewDataSource
            dSource.nextMensaDay()
            displayStepperButtonsIfNeeded()
            tableView.reloadData()
        }
    }
    
    @IBAction func showPreviousDayAction(_ sender: UIButton) {
        // iPhone
        if let tableView = self.superview as? UITableView {
            let dSource = tableView.dataSource as! SpeiseplanTableViewDataSource
            dSource.previousMensaDay()
            displayStepperButtonsIfNeeded()
            tableView.reloadData()
        }
        // iPad
        if let tableView = self.superview?.superview as? UITableView {
            let dSource = tableView.dataSource as! SpeiseplanTableViewDataSource
            dSource.previousMensaDay()
            displayStepperButtonsIfNeeded()
            tableView.reloadData()
        }
    }
    
    func displayStepperButtonsIfNeeded() {
        if let tableView = self.superview as? UITableView {
            let dSource = tableView.dataSource as! SpeiseplanTableViewDataSource
            previousMensaDayButton.isEnabled = dSource.hasPreviousMensaDay()
            nextMensaDayButton.isEnabled = dSource.hasNextMensaDay()
        }
    }
    
    
}
