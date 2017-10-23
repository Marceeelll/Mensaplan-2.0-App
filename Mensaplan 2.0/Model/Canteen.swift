//
//  Canteen.swift
//  Mensaplan 2.0
//
//  Created by Marcel Hagmann on 20.10.17.
//  Copyright © 2017 Marcel Hagmann. All rights reserved.
//

import Foundation

enum Canteen {
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
}
