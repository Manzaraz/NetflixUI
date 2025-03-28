//
//  Profile.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 27/03/2025.
//

import SwiftUI

struct Profile: Identifiable {
    var id: UUID = .init()
    var name: String
    var icon: String
    
    var sourceAnchorID: String {
        return id.uuidString + "SOURCE"
    }
    
    var destinationAnchorID: String {
        return id.uuidString + "DESTINATION"
    }
}


var mockProfile: [Profile] = [
    .init(name: "iJustine", icon: "iJustine"),
    .init(name: "Jenna", icon: "iJenna")
]

