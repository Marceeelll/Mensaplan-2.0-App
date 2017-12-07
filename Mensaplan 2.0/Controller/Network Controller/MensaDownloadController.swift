//
//  DownloadController.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

class MensaDownloadController : NSObject, FetchDataDelegate {
    var invalidated: Bool = false
    var didErrorOccured: Bool = false
    
    var mensaData = MensaData()
    
    let urlBuilder = MensaURLBuilder()
    
    var loaders: [FetchData] = []
    var workItems: [DispatchWorkItem] = []
    var downloadGroup: DispatchGroup
    
    var delegate: MensaDownloadDelegate?
    
    var numberOfDownloads: Int = 0
    var numberOfAlreadyDownloaded: Int = 0
    
    var tmpMensaData: [MensaDay] = []
    
    override init() {
        downloadGroup = DispatchGroup()
    }
    
    func didFinished(with error: Error) {
        if !didErrorOccured {
            delegate?.downloadError(description: error.localizedDescription)
            invalidate()
        }
        didErrorOccured = true
        downloadGroup.leave()
    }
    
    func didFinishedDataProcessing(for id: Int, with data: MensaDay) {
        tmpMensaData.append(data)
        downloadGroup.leave()
        numberOfAlreadyDownloaded += 1
        delegate?.download(alreadyDownloaded: numberOfAlreadyDownloaded, of: numberOfDownloads)
    }
    
    func start() {
        resetAll()
        
        for dayInFuture in 0..<userProfile.numberOfDaysToDownload {
            if invalidated {
                resetAll()
                return
            }
            
            let workItem = DispatchWorkItem(block: {
                if let date = Date.getDate(in: dayInFuture) {
                    let loader = FetchData()
                    loader.delegate = self
                    loader.id = dayInFuture
                    loader.date = date
                    
                    let serialQueue = DispatchQueue(label: "serialQueue")
                    serialQueue.sync {
                        self.loaders.append(loader)
                    }
                    
                    let url = self.urlBuilder.url(for: date)
                    
                    loader.fetchData(for: url)
                }
            })
            
            workItems.append(workItem)
            
            if isLastJob(dayToDownload: dayInFuture) {
                numberOfDownloads = workItems.count
                for job in workItems {
                    downloadGroup.enter()
                    DispatchQueue.global(qos: .userInitiated).async(execute: job)
                }
                downloadGroup.notify(queue: .main, execute: {
                    self.processedDownloadedData()
                })
            }
            
        }
    }
    
    func isLastJob(dayToDownload: Int) -> Bool {
        return dayToDownload == userProfile.numberOfDaysToDownload - 1
    }
    
    func invalidate() {
//        dispatchPrecondition(condition: .onQueue(.main))
        invalidated = true
        cancelAllNetworkConnections()
        cancelAllJobs()
    }
    
    private func cancelAllJobs() {
        for job in workItems {
            job.cancel()
        }
    }
    
    private func cancelAllNetworkConnections() {
        for loader in loaders {
            loader.cancel()
        }
    }
    
    private func resetAll() {
        invalidated = false
        didErrorOccured = false
        downloadGroup = DispatchGroup()
        workItems = []
        tmpMensaData = []
        loaders = []
        numberOfAlreadyDownloaded = 0
    }
    
    private func processedDownloadedData() {
        if !didErrorOccured {
            mensaData.set(mensaDays: tmpMensaData)
            mensaData.sortMensaDays()
        }
        self.resetAll()
        MensaData().didUpdate()
        delegate?.downloadDone()
    }
}





