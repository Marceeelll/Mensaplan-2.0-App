//
//  ViewController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 17.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import UIKit

class SpeiseplanViewController: UIViewController, MensaDownloadDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var downloadProgressView: UIDownloadProgressView!
    @IBOutlet weak var downloadProgressViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    
    // MARK: - Instance Variable
    let downloadCtrl = MensaDownloadController()
    
    var dataSource: SpeiseplanTableViewDataSource!
    var delegate: SpeiseplanTableViewDelegate!
    
    
    deinit {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: Notification.Name.changedSettings, object: nil)
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadCtrl.delegate = self
        
        dataSource = SpeiseplanTableViewDataSource()
        delegate = SpeiseplanTableViewDelegate(viewCtrl: self)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        
        downloadProgressView.cancelClosure = {
            self.downloadCtrl.invalidate()
        }
        
        setUpUI()
        setUpDesign(for: self.navigationController, for: self.tabBarController)
        tableView.backgroundColor = appColor.background
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(changedSettings(_:)), name: Notification.Name.changedSettings, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboardSegueIDSpeiseplanToMealDetail {
            let destCtrl = segue.destination as! DetailMealViewController
            destCtrl.receivedMeal = delegate.selectedMeal
            destCtrl.mealCategorieName = delegate.selectedMealCategorieName
        }
    }
    
    
    // MARK: - Help Methods
    @objc func changedSettings(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            var changedOfflineDays = false
            var changedAllergies = false
            var changedTarif = false
            var changedMensa = false
            
            if let offlineDays = userInfo["changedOfflineDays"] as? Bool {
                changedOfflineDays = offlineDays
            }
            if let allergies = userInfo["changedAllergies"] as? Bool {
                changedAllergies = allergies
            }
            if let tarif = userInfo["changedTarif"] as? Bool {
                changedTarif = tarif
            }
            if let mensa = userInfo["changedMensa"] as? Bool {
                changedMensa = mensa
            }
            
            if changedOfflineDays || changedMensa {
                MensaData().reset()
                setUpUI()
                dataSource.resetCurrentIndexToZero()
            }
            if changedOfflineDays || changedMensa || changedTarif || changedAllergies {
                tableView.reloadData()
            }
            
        }
    }
    
    func setUpUI() {
        self.title = userProfile.canteen.mensaName
        
        let refresh = UIRefreshControl()
        refresh.tintColor = appColor.text
        refresh.addTarget(self, action: #selector(startDownloadAction(_:)), for: .valueChanged)
        tableView.refreshControl = refresh
        
        disableDownloadProgressView(false)
    }

    
    // MARK: - Animations
    func showDownloadProgressView() {
        downloadProgressViewHeightConstraint.constant = 49
        downloadProgressView.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func disableDownloadProgressView(_ animate: Bool = true) {
        downloadProgressViewHeightConstraint.constant = 0
        if animate {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }, completion: { finished in
                if finished {
                    self.downloadProgressView.isHidden = true
                }
            })
        } else {
            self.view.layoutIfNeeded()
            self.downloadProgressView.isHidden = true
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func startDownloadAction(_ sender: UIBarButtonItem) {
        print("Start Download Action")
        downloadCtrl.start()
        downloadProgressView.start()
        showDownloadProgressView()
        refreshButton.isEnabled = false
    }
    
    
    // MARK: - MensaDownloadDelegate
    func downloadDone() {
        print("Download Done")

        dataSource.reloadCurrentMensaDay()
        downloadProgressView.stop()
        disableDownloadProgressView()
        refreshButton.isEnabled = true
        tableView.refreshControl?.endRefreshing()
        let dateCellIndexPath = IndexPath(row: 0, section: 0)
        let dateCell = tableView.cellForRow(at: dateCellIndexPath) as! UISpeiseplanTableViewDateCell
        dateCell.displayStepperButtonsIfNeeded()
        tableView.reloadData()
        MensaData().didUpdate()
    }
    
    func download(alreadyDownloaded: Int, of allDownloads: Int) {
        DispatchQueue.main.async {
            self.downloadProgressView.setProgress(alreadyDownloaded, of: allDownloads)
        }
    }
    
    @IBAction func testAction(_ sender: UIBarButtonItem) {
        print("Test Action")
        print("Test: \(userProfile)")
//        let store = MensaStore()
//        let days = MensaData().mensaDays
////        store.save(days: days)
//
//        do {
//            let encoder = JSONEncoder()
//            let userData = UserProfileDataSingleton.sharedInstance
//            let encodedData = try encoder.encode(userData)
//            let jsonSTring = String(data: encodedData, encoding: String.Encoding.utf8)
//        } catch {
//            print(error)
//        }
        
    }
}










