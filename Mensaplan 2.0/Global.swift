//
//  Global.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 17.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit


// MARK: - IBOutlets
// MARK: - Instance Variable
// MARK: - Lifecycle
// MARK: - Help Methods
// MARK: - Animations
// MARK: - IBActions
// MARK: - Delegates


// ✅ Hier muss etwas ereldigt werden
// ⚠️ Hier ist eine Zeile, die nur für Debugging drin steht
// 🔮 Die Klasse ist vollständig dokumentiert

// MARK - StoryboardSegueID`s
let storyboardSegueIDSettingsToMensaSelection = "storyboardSegueIDSettingsToMensaSelection"
let storyboardSegueIDSpeiseplanToMealDetail = "storyboardSegueIDSpeiseplanToMealDetail"
let storyboardSegueIDSettingsToAllergiesSelection = "storyboardSegueIDSettingsToAllergiesSelection"

// MARK: - Global Variables
var appColor = AppColor(appearance: .dark)
let userProfile = UserProfileData()

struct MensaURLBuilder {
    func url(for date: Date) -> URL {
        let dayComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
        let day = dayComponents.day!
        let month = dayComponents.month!
        let year = dayComponents.year!
        let dayFormat = String(format: "%02d", arguments: [day])
        let monthFormat = String(format: "%02d", arguments: [month])
        let urlString = "\(userProfile.canteen.mensaURLString)\(year)-\(monthFormat)-\(dayFormat).html"
        return URL(string: urlString)!
    }
}




