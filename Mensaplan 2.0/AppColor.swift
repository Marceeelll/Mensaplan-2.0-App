//
//  AppColor.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import UIKit

struct AppColor: Codable {
    var appearance: Appearance
    
    init(appearance: Appearance) {
        self.appearance = appearance
    }
    
    var background: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.white
            case .dark: return UIColor(red: 53.0/255.0, green: 61.0/255.0, blue: 65.0/255.0, alpha: 1.0)
            }
        }
    }
    
    var priceView: UIColor {
        get {
            switch appearance {
            case .light: return UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            case .dark: return UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            }
        }
    }
    
    var cellBackground: UIColor {
        return background
    }
    
    var controllItem: UIColor {
        return navigationBarBackground
    }
    
    var tableViewCellTintColor: UIColor {
        return navigationBarBackground
    }
    
    var navigationBarBackground: UIColor {
        get {
            switch appearance {
            case .light: return UIColor(red: 109.0/255.0, green: 202.0/255.0, blue: 113.0/255.0, alpha: 1.0)
            case .dark: return UIColor(red: 109.0/255.0, green: 202.0/255.0, blue: 113.0/255.0, alpha: 1.0)
            }
        }
    }
    
    var navigationBarText: UIColor {
        return UIColor.white
    }
    
    var tabBarBackground: UIColor {
        return navigationBarBackground
    }
    
    var tabBarText: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.white
            case .dark: return UIColor.white
            }
        }
    }
    
    var tabBarImageColor: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.white
            case .dark: return UIColor.white
            }
        }
    }
    
    var text: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.darkGray
            case .dark: return UIColor.white
            }
        }
    }
    
    var dangerousText: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.red
            case .dark: return UIColor.red
            }
        }
    }
    
    var warningOfIngredients: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.red
            case .dark: return UIColor.red
            }
        }
    }
    
    var tableViewHeader: UIColor {
        get {
            switch appearance {
            case .light: return navigationBarBackground
            case .dark: return UIColor(red: 82.0/255.0, green: 86.0/255.0, blue: 88.0/255.0, alpha: 1.0)
            }
        }
    }
    
    var tableViewHeaderText: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.white
            case .dark: return UIColor.white
            }
        }
    }
    
    
    
    enum Appearance: String, Codable {
        case light = "light"
        case dark = "dark"
    }
}
