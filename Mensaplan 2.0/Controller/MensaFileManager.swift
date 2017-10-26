//
//  MensaFileManager.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 26.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

class MensaFileManager {
    static let standard = MensaFileManager()
    private init() {}
    
    func save(_ data: Data?, for fileName: String, forKey key: String) {
        let file = dataFileForName(fileName: fileName)
        let mutableData = NSMutableData()
        
        let archiver = NSKeyedArchiver(forWritingWith: mutableData)
        archiver.encode(data, forKey: key)
        archiver.finishEncoding()
        mutableData.write(toFile: file, atomically: true)
    }
    
    func load(fileName: String, forKey key: String) -> Data? {
        let file = dataFileForName(fileName: fileName)
        
        if !FileManager.default.fileExists(atPath: file) {
            return nil
        }
        
        if let nsdata = NSData(contentsOfFile: file) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: nsdata as Data)
            let result = unarchiver.decodeObject(forKey: key) as? Data
            unarchiver.finishDecoding()
            return result
        }
        return nil
    }
    
    private func documentPath() -> String {
        let allPathes = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return allPathes[0]
    }
    
    private func dataFileForName(fileName : String) -> String {
        return (documentPath() as NSString).appendingPathComponent(fileName)
    }
}
