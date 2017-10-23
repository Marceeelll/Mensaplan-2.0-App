//
//  AppColor.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 19.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//
// 🔮

import UIKit

class AppColor {
    var appearance: Appearance
    
    init(appearance: Appearance) {
        self.appearance = appearance
    }
    
    var background: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.white
            case .dark: return UIColor.darkGray
            }
        }
    }
    
    var navigationBarBackground: UIColor {
        get {
            switch appearance {
            case .light: return UIColor.white
            case .dark: return UIColor.darkGray
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
            case .light: return UIColor.lightGray
            case .dark: return UIColor.lightGray
            }
        }
    }
    
    
    
    enum Appearance: String {
        case light = "light"
        case dark = "dark"
    }
}
