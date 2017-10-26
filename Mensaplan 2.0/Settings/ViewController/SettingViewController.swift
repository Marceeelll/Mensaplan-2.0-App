//
//  SettingViewController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 18.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import UIKit
import MessageUI
import StoreKit

class SettingViewController: UITableViewController, MensaSelectionDelegate, AllergiesSelectionDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var designAppearanceSwitch: UISwitch!
    @IBOutlet weak var appNameVersionLabel: UILabel!
    @IBOutlet weak var tariffSegmentedControll: UISegmentedControl!
    @IBOutlet weak var downloadDaysSlider: UISlider!
    @IBOutlet weak var selectedCanteenLabel: UILabel!
    @IBOutlet weak var numberOfDaysToDownloadLabel: UILabel!
    
    
    // MARK: - Instance Variable
    let appName = "Mensaplan"
    var version = "2.0"
    
    var changedDic: [String:Bool] = [:]
    
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAppVersion()
        setUpUI()
        setUpDesign()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear -----")
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name.changedSettings, object: nil, userInfo: changedDic)
        changedDic = [:]
    }
    
    
    // MARK: - Help Methods
    func setUpUI() {
        appNameVersionLabel.text = "\(appName) \(version)"
        downloadDaysSlider.value = Float(userProfile.numberOfDaysToDownload)
        
        for index in 0..<PriceLevel.allPriceLevels.count {
            let priceLevel = PriceLevel.allPriceLevels[index]
            tariffSegmentedControll.setTitle(priceLevel.priceLevelName, forSegmentAt: index)
        }
    }
    
    func setUpDesign() {
        Mensaplan_2_0.setUpDesign(for: self.navigationController, for: self.tabBarController)
        tariffSegmentedControll.tintColor = appColor.controllItem
        downloadDaysSlider.minimumTrackTintColor = appColor.controllItem
        designAppearanceSwitch.onTintColor = appColor.controllItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboardSegueIDSettingsToMensaSelection {
            let destCtrl = segue.destination as! MensaSelectionTableViewController
            destCtrl.selectionDelegate = self
        } else if segue.identifier == storyboardSegueIDSettingsToAllergiesSelection {
            let destCtrl = segue.destination as! AllergiesSelectionTableViewController
            destCtrl.selectionDelegate = self
        }
    }
    
    func loadAppVersion() {
        version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    func displayTellFriendsAboutThisApp() {
        if !MFMessageComposeViewController.canSendText() {
            return
        }
        let messageCtrl = MFMessageComposeViewController()
        messageCtrl.messageComposeDelegate = self
        messageCtrl.body = "Hey, hier ein Link zu einer brillianten App für eine tolle Ansicht der aktuellen Speisen in der Mensa. Das Tolle bei der App ist, dass du deine Essensvorlieben (Allergien, vegetarisch, etc.) einstellen kannst und gewarnt wirst, wenn in irgendeinem Essen etwas davon drin ist. Und man kann die App sogar auch offline verwenden (spart Datenvolumen).\n\n https://itunes.apple.com/us/app/mensaplan-oberfranken-bayern/id1111214856?ls=1&mt=8"
        present(messageCtrl, animated: true)
    }
    
    func displayEmailFeedbackController() {
        if !MFMailComposeViewController.canSendMail() {
            return
        }
        let emailCtrl = MFMailComposeViewController()
        emailCtrl.mailComposeDelegate = self
        emailCtrl.setToRecipients(["hagmannmarcel.developer@yahoo.com"])
        emailCtrl.setSubject("Mensaplan 2.0 - Feedback")
        self.present(emailCtrl, animated: true)
    }
    
    func displayRateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            let appStoreLink = URL(string: "https://itunes.apple.com/us/app/mensaplan-oberfranken-bayern/id1111214856?ls=1&mt=8")!
            UIApplication.shared.open(appStoreLink, options: [:], completionHandler: nil)
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func changedTariffSegmentedControllAction(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        let newPriceLevel = PriceLevel.allPriceLevels[selectedIndex]
        userProfile.set(new: newPriceLevel)
        changedDic["changedTarif"] = true
    }
    
    @IBAction func downloadDaysChangedSliderAction(_ sender: UIStepSlider) {
        let numberOfDaysToDownload = Int(sender.value)
        userProfile.set(numberOfDaysToDownload: numberOfDaysToDownload)
        numberOfDaysToDownloadLabel.text = "Tage: \(numberOfDaysToDownload)"
        changedDic["changedOfflineDays"] = true
    }
    
    @IBAction func changedDesignSwitchAction(_ sender: UISwitch) {
        switch appColor.appearance {
        case .dark: appColor.appearance = .light
        case .light: appColor.appearance = .dark
        }
    }
    
    
    // MARK: - MensaSelectionDelegate
    func receive(selection indexPath: IndexPath, canteen: Canteen) {
        navigationController?.popViewController(animated: true)
        selectedCanteenLabel.text = "Mensa \(canteen.mensaName)"
        changedDic["changedMensa"] = true
    }
    
    
    // MARK: - AllergiesSelectionDelegate
    func receiveAllergies(didSelect: Bool) {
        changedDic["changedAllergies"] = didSelect
    }
    
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                displayTellFriendsAboutThisApp()
            } else if indexPath.row == 1 {
                displayEmailFeedbackController()
            } else if indexPath.row == 2 {
                displayRateApp()
            }
        }
    }
    
    
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
    
    
    // MARK: - MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true)
    }
}
