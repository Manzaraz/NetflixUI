//
//  Tab.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 26/03/2025.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "Home"
    case new = "New & Hot"
    case account = "My Netflix"
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .new:
            return "play.rectangle.on.rectangle.fill"
        case .account:
            return "Profile"
        }
    }
}
