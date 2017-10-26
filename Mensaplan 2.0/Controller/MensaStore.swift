//
//  MensaStore.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 26.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

class MensaStore {
    
    private enum FileSystemStrings {
        case userData
        case mensaData
        
        var fileName: String {
            switch self {
            case .mensaData: return "mensaData.txt"
            case .userData: return "userData.txt"
            }
        }
        
        var key: String {
            switch self {
            case .mensaData: return "mensaDataKey"
            case .userData: return "userDataKey"
            }
        }
    }
    
    // MARK: - MensaData
    func save(days: [MensaDay]) {
        let encoder = JSONEncoder()
        do {
            let mensaDataStrings = FileSystemStrings.mensaData
            let encodedData = try encoder.encode(days)
            MensaFileManager.standard.save(encodedData, for: mensaDataStrings.fileName, forKey: mensaDataStrings.key)
        } catch {
            print("error-save(days: [MensaDay]): \(error)")
        }
    }
    
    func loadMensaDay() -> [MensaDay] {
        let decoder = JSONDecoder()
        do {
            let mensaDataStrings = FileSystemStrings.mensaData
            if let data = MensaFileManager.standard.load(fileName: mensaDataStrings.fileName, forKey: mensaDataStrings.key) {
                let decodedData = try decoder.decode([MensaDay].self, from: data)
                return decodedData
            }
        } catch {
            print("error-loadMensaDay(): \(error)")
        }
        return []
    }
    
    
    // MARK: - UserProfileData
    func save(userProfile: UserProfileDataSingleton) {
        let encoder = JSONEncoder()
        do {
            let userProfileDataStrings = FileSystemStrings.userData
            let encodedData = try encoder.encode(userProfile)
            MensaFileManager.standard.save(encodedData, for: userProfileDataStrings.fileName, forKey: userProfileDataStrings.key)
        } catch {
            print("error-save(userProfile: UserProfileDataSingleton): \(error)")
        }
    }
    
    func loadUserProfileData() -> UserProfileDataSingleton {
        let decoder = JSONDecoder()
        do {
            let userProfileDataStrings = FileSystemStrings.userData
            if let data = MensaFileManager.standard.load(fileName: userProfileDataStrings.fileName, forKey: userProfileDataStrings.key) {
                let decodedData = try decoder.decode(UserProfileDataSingleton.self, from: data)
                return decodedData
            }
        } catch {
            print("error-loadUserProfileData(): \(error)")
        }
        return UserProfileDataSingleton.sharedInstance
    }
}


