//
//  MensaInfoViewController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 18.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import UIKit

class MensaInfoViewController: UIViewController {
    @IBOutlet weak var mensaInfoLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign(for: self.navigationController, for: self.tabBarController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mensaInfoLabel.text = getMensaInfoText()
    }
    
    func getMensaInfoText() -> String {
        let adress = userProfile.canteen.mensaAdress
        let openingTimes = userProfile.canteen.openingTimes
        return "\(adress)\n\n\(openingTimes)"
    }
    
}
