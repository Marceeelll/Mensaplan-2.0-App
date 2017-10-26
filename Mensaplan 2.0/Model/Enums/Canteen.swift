//
//  Canteen.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

enum Canteen: Int, Codable {
    case Amberg
    case CoburgHauptmensa
    case CoburgCampusDesign
    case BayreuthHauptmensa
    case BayreuthFrischraum
    case Hof
    case Münchberg
    case Weiden
    
    static let allCanteens = [Canteen.Amberg, .CoburgHauptmensa, .CoburgCampusDesign, .BayreuthHauptmensa, .BayreuthFrischraum, .Hof, .Münchberg, .Weiden]
    
    var mensaName: String {
        switch self {
        case .Amberg: return "Amberg"
        case .CoburgHauptmensa: return "Coburg Hauptmensa"
        case .CoburgCampusDesign: return "Coburg Campus Design"
        case .BayreuthHauptmensa: return "Bayreuth Hauptmensa"
        case .BayreuthFrischraum: return "Bayreuth Frischraum"
        case .Hof: return "Hof"
        case .Münchberg: return "Münchberg"
        case .Weiden: return "Weiden"
        }
    }
    
    var mensaURLString: String {
        switch self {
        case .Amberg: return "https://www.studentenwerk-oberfranken.de/essen/speiseplaene/amberg/"
        case .CoburgHauptmensa: return "https://www.studentenwerk-oberfranken.de/essen/speiseplaene/coburg/hauptmensa/"
        case .CoburgCampusDesign: return "https://www.studentenwerk-oberfranken.de/essen/speiseplaene/coburg/campus-design/"
        case .BayreuthHauptmensa: return "https://www.studentenwerk-oberfranken.de/essen/speiseplaene/bayreuth/hauptmensa/"
        case .BayreuthFrischraum: return "https://www.studentenwerk-oberfranken.de/essen/speiseplaene/bayreuth/frischraum/"
        case .Hof: return "https://www.studentenwerk-oberfranken.de/essen/speiseplaene/hof/"
        case .Münchberg: return "https://www.studentenwerk-oberfranken.de/essen/speiseplaene/muenchberg/"
        case .Weiden: return "https://www.studentenwerk-oberfranken.de/essen/speiseplaene/weiden/"
        }
    }
    
    var mensaAdress: String {
        switch userProfile.canteen {
        case .Amberg: return "Mensa - \(mensaName)\nKaiser-Wilhelm-Ring 23\n92224 Amberg"
        case .BayreuthFrischraum: return "Mensa - \(mensaName)\nUniversitätsstraße 30\n95447 Bayreuth"
        case .BayreuthHauptmensa: return "Mensa - \(mensaName)\nUniversitätsstraße 30\n95447 Bayreuth"
        case .CoburgCampusDesign: return "Mensa - \(mensaName)\nFriedrich-Streib-Straße 2\n96450 Coburg"
        case .CoburgHauptmensa: return "Mensa - \(mensaName)\nFriedrich-Streib-Straße 2\n96450 Coburg"
        case .Hof: return "Mensa - \(mensaName)\nWirthstraße 51\n95028 Hof"
        case .Münchberg: return "Mensa - \(mensaName)\nKulmbacher Str. 76\n95213 Münchberg"
        case .Weiden: return "Mensa - \(mensaName)\nHetzenrichter Weg 15\n92637 Weiden"
        }
    }
    
    var openingTimes: String {
        switch userProfile.canteen {
        case .Amberg: return "Öffnungszeiten:\nMo - Mi   06:30 - 15:00 Uhr\nDo            06:30 - 14:30 Uhr\nFr             06:30 - 13:15 Uhr\nMittagessen 11:00 - 13:30"
        case .BayreuthFrischraum: return "Öffnungszeiten:\nMo - Fr   11:00 - 20:30 Uhr\nEssensausgabe bis 20:00 Uhr"
        case .BayreuthHauptmensa: return "Öffnungszeiten:\nMo - Do   11:00 - 14:00 Uhr\nFr            11:00 - 13:30 Uhr"
        case .CoburgCampusDesign: return "Öffnungszeiten:\nMo - Do   11:00 - 14:00 Uhr\nFr            11:00 - 13:30 Uhr"
        case .CoburgHauptmensa: return "Öffnungszeiten:\nMo - Do   11:00 - 14:00 Uhr\nFr            11:00 - 13:30 Uhr"
        case .Hof: return "Öffnungszeiten:\nMo - Do   11:00 - 14:15 Uhr\nFr            11:00 - 13:45 Uhr"
        case .Münchberg: return "Öffnungszeiten:\nMo - Do   11:30 - 13:15 Uhr\nFr            11:30 - 13:00 Uhr"
        case .Weiden: return "Öffnungszeiten:\nMo - Fr   11:00 - 14:00 Uhr"
        }
    }
}
