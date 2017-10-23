//
//  UIDownloadProgressView.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 22.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class UIDownloadProgressView: UIView {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressTextLabel: UILabel!
    
    var cancelClosure: (() -> ())? = nil
    
    func start() {
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func cancelDownloadAction(_ sender: UIButton) {
        print("Canceld Download Button Action")
        if let cancelClosure = cancelClosure {
            cancelClosure()
        }
    }
    
    func setProgress(_ alreadyDownloaded: Int, of allDownloads: Int) {
        let progressText = "Download: \(alreadyDownloaded) von \(allDownloads) Tagen"
        progressTextLabel.text = progressText
        let progress = Float(alreadyDownloaded) / Float(allDownloads)
        progressView.setProgress(progress, animated: true)
    }

}
