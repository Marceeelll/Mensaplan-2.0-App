//
//  UIMealIconView.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 18.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import UIKit

class UIMealIconView : UIView {
    
    private var oneMealIconImageView: UIImageView!
    private var twoMealIconLeftImageView: UIImageView!
    private var twoMealIconRightImageView: UIImageView!
    
    private var halfCircleShape: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUpMealIconView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUpMealIconView()
    }
    
    func initUpMealIconView() {
        let rotationLeftInRadians: CGFloat = -0.785398 // -45°
        let rotationRightInRadians: CGFloat = 0.785398 // 45°
        
        
        self.backgroundColor = UIColor.orange
        self.makeViewRound()
        
        // Draw Half Circle
        let center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let halfCirclePath = UIBezierPath(arcCenter: center,
                                          radius: self.frame.width/2,
                                          startAngle: CGFloat(0),
                                          endAngle: CGFloat.pi,
                                          clockwise: false)
        halfCircleShape = CAShapeLayer()
        halfCircleShape.path = halfCirclePath.cgPath
        self.layer.addSublayer(halfCircleShape)
        
        
        // One Meal Icon - Hinzufügen
        let oneMealIconShift = self.frame.width/4
        oneMealIconImageView = UIImageView(frame: CGRect(x: oneMealIconShift, y: oneMealIconShift,
                                                     width: self.frame.width/2, height: self.frame.height/2))
        oneMealIconImageView.transform = oneMealIconImageView.transform.rotated(by: rotationRightInRadians)
        addSubview(oneMealIconImageView)
        
        
        // Two Meal Icon Left - Hinzufügen
        // Icon wird um 20% geschrumpt (size: 0.8) und um 10% auf x verschoben
        let x: CGFloat = self.frame.width / 4 * 1.1
        var y: CGFloat = 2
        let size: CGFloat = self.frame.height / 2 * 0.8
        twoMealIconLeftImageView = UIImageView(frame: CGRect(x: x, y: y, width: size, height: size))
        twoMealIconLeftImageView.transform = twoMealIconLeftImageView.transform.rotated(by: rotationRightInRadians)
        self.addSubview(twoMealIconLeftImageView)
        
        // Two Meal Icon Right - Hinzufügen
        y = self.frame.height / 2 + 2
        twoMealIconRightImageView = UIImageView(frame: CGRect(x: x, y: y, width: size, height: size))
        twoMealIconRightImageView.transform = twoMealIconRightImageView.transform.rotated(by: rotationRightInRadians)
        self.addSubview(twoMealIconRightImageView)
        
        self.transform = self.transform.rotated(by: rotationLeftInRadians)
    }
    
    
    func display(icons: [MealIconType]) {
        oneMealIconImageView.image = nil
        twoMealIconLeftImageView.image = nil
        twoMealIconRightImageView.image = nil
        
        if icons.count == 1 {
            oneMealIconImageView.image = icons[0].iconImage
            self.backgroundColor = icons[0].color
            halfCircleShape.isHidden = true
        } else if icons.count > 1 {
            twoMealIconLeftImageView.image = icons[0].iconImage
            twoMealIconRightImageView.image = icons[1].iconImage
            
            halfCircleShape.isHidden = false
            halfCircleShape.fillColor = icons[0].color.cgColor
            self.backgroundColor = icons[1].color
        }
    }
    
    enum MealIconType {
        case beef
        case fish
        case homemade
        case lamb
        case mensaVital
        case notVegetarian
        case pig
        case poultry
        case regional
        case seafood
        case sustainableCatch
        case vegan
        case vegetarian
        case wild
        case error
        
        static let allMeals: [MealIconType] = [.beef, .fish, .homemade, .lamb, .mensaVital, .notVegetarian, .pig, .poultry, .regional, .seafood, .sustainableCatch, .vegan, .vegetarian, .wild]
        
        var iconImage: UIImage? {
            switch self {
            case .beef: return UIImage(named: "icon_beef")
            case .fish: return UIImage(named: "icon_fish")
            case .homemade: return UIImage(named: "icon_homemade")
            case .lamb: return UIImage(named: "icon_lamb")
            case .mensaVital: return UIImage(named: "icon_mensaVital")
            case .notVegetarian: return UIImage(named: "icon_not_vegetarian")
            case .pig: return UIImage(named: "icon_pig")
            case .poultry: return UIImage(named: "icon_poultry")
            case .regional: return UIImage(named: "icon_regional")
            case .seafood: return UIImage(named: "icon_seafood")
            case .sustainableCatch: return UIImage(named: "icon_sustainableCatch")
            case .vegan: return UIImage(named: "icon_vegan")
            case .vegetarian: return UIImage(named: "icon_vegetarian")
            case .wild: return UIImage(named: "icon_wild")
            case .error: return UIImage(named: "icon_unknown")
            }
        }
        
        var color: UIColor {
            switch self {
            case .beef: return UIColor(red: 177.0/255.0, green: 142.0/255.0, blue: 121.0/255.0, alpha: 1.0)
            case .fish: return UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0)
            case .homemade: return UIColor(red: 174.0/255.0, green: 168.0/255.0, blue: 164.0/255.0, alpha: 1.0)
            case .lamb: return UIColor(red: 204.0/255.0, green: 178.0/255.0, blue: 161.0/255.0, alpha: 1.0)
            case .mensaVital: return UIColor(red: 122.0/255.0, green: 168.0/255.0, blue: 49.0/255.0, alpha: 1.0)
            case .notVegetarian: return UIColor(red: 221.0/255.0, green: 233.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            case .pig: return UIColor(red: 254.0/255.0, green: 210.0/255.0, blue: 229.0/255.0, alpha: 1.0)
            case .poultry: return UIColor(red: 220.0/255.0, green: 207.0/255.0, blue: 130.0/255.0, alpha: 1.0)
            case .regional: return UIColor(red: 209.0/255.0, green: 123.0/255.0, blue: 123.0/255.0, alpha: 1.0)
            case .seafood: return UIColor(red: 239.0/255.0, green: 89.0/255.0, blue: 55.0/255.0, alpha: 1.0)
            case .sustainableCatch: return UIColor(red: 83.0/255.0, green: 124.0/255.0, blue: 169.0/255.0, alpha: 1.0)
            case .vegan: return UIColor(red: 253.0/255.0, green: 153.0/255.0, blue: 39.0/255.0, alpha: 1.0)
            case .vegetarian: return UIColor(red: 167.0/255.0, green: 193.0/255.0, blue: 151.0/255.0, alpha: 1.0)
            case .wild: return UIColor(red: 164.0/255.0, green: 115.0/255.0, blue: 86.0/255.0, alpha: 1.0)
            case .error: return UIColor(red: 162.0/255.0, green: 193.0/255.0, blue: 231.0/255.0, alpha: 1.0)
            }
        }
        
        var name: String {
            switch self {
            case .beef: return "Rind"
            case .fish: return "Fisch"
            case .homemade: return "Hausgemacht"
            case .lamb: return "Lamm"
            case .mensaVital: return "Mensa Vital"
            case .notVegetarian: return "Nicht vegetarisch"
            case .pig: return "Schwein"
            case .poultry: return "Geflügel"
            case .regional: return " Regional"
            case .seafood: return "Meeresfrüchte"
            case .sustainableCatch: return"Nachhaltiger Fang"
            case .vegan: return "Vegan"
            case .vegetarian: return "Vegetarisch"
            case .wild: return "Wild"
            case .error: return "Error"
            }
        }
        
        static func getMealIconType(for string: String) -> MealIconType {
            switch string {
            case "Rind": return .beef
            case "Fisch": return .fish
            case "hausgemacht": return .homemade
            case "Lamm": return .lamb                           // TODO: ✅🚨 ????????
            case "Mensa Vital": return .mensaVital                     // TODO: ✅🚨 ????????
            case "Tier. Lab/Gelatine": return .notVegetarian
            case "Schwein": return .pig
            case "Geflügel": return .poultry
            case "regional": return .regional
            case "Meeresfrüchte": return .seafood
            case "nachhaltiger Fang": return .sustainableCatch
            case "vegan": return .vegan
            case "vegetarisch": return .vegetarian
            case "Wild": return .wild
            default: return .error
            }
        }
    }
}
