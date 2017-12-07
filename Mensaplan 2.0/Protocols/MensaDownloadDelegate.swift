//
//  MensaDownloadDelegate.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

protocol MensaDownloadDelegate {
    func downloadDone()
    func download(alreadyDownloaded: Int, of allDownloads: Int)
    func downloadError(description: String)
}
