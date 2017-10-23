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
    @IBOutlet weak var currentDayStepper: UIStepper!
    @IBOutlet weak var downloadProgressView: UIDownloadProgressView!
    @IBOutlet weak var downloadProgressViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    
    // MARK: - Instance Variable
    var currentDay = 0
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
        
        let mensaDay = MensaData().getMensaDay(for: currentDay)
        dataSource = SpeiseplanTableViewDataSource(mensaDay: mensaDay)
        delegate = SpeiseplanTableViewDelegate(viewCtrl: self)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        
        downloadProgressView.cancelClosure = {
            self.downloadCtrl.invalidate()
        }
        
        setUpUI()
        
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
            
            switch (changedOfflineDays, changedMensa, changedTarif, changedAllergies) {
            case (true, _, _, _):
                currentDay = 0
                currentDayStepper.value = 0
                fallthrough
            case (_, true, _, _):
                MensaData().reset()
                setUpUI()
                showNextDay()
            case (_, _, true, _): fallthrough
            case (_, _, _, true): tableView.reloadData()
            default: break
            }
        }
    }
    
    func setUpUI() {
        self.title = userProfile.canteen.mensaName
        
        currentDayStepper.maximumValue = Double(userProfile.numberOfDaysToDownload - 1)
        currentDayStepper.setDecrementImage(UIImage(named: "icon_left"), for: .normal)
        currentDayStepper.setIncrementImage(UIImage(named: "icon_right"), for: .normal)
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(startDownloadAction(_:)), for: .valueChanged)
        tableView.refreshControl = refresh
        
        disableDownloadProgressView(false)
    }
    
    func showNextDay() {
        let mensaDay = MensaData().getMensaDay(for: currentDay)
        dataSource.data = mensaDay
        tableView.reloadData()
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
    
    @IBAction func currentDayChangedAction(_ sender: UIStepper) {
        currentDay = Int(sender.value)
        showNextDay()
    }
    
    
    // MARK: - MensaDownloadDelegate
    func downloadDone() {
        print("Download Done")
        
        let mensaDay = MensaData().getMensaDay(for: currentDay)
        dataSource.data = mensaDay
        downloadProgressView.stop()
        disableDownloadProgressView()
        tableView.reloadData()
        refreshButton.isEnabled = true
        tableView.refreshControl?.endRefreshing()
        MensaData().didUpdate()
    }
    
    func download(alreadyDownloaded: Int, of allDownloads: Int) {
        DispatchQueue.main.async {
            self.downloadProgressView.setProgress(alreadyDownloaded, of: allDownloads)
        }
    }
}

