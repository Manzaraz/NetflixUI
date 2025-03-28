//
//  AppData.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 26/03/2025.
//

import SwiftUI

@Observable
class AppData {
    var isSplashFinished: Bool = false
    var activeTab: Tab = .home
    
    /// Profile Selection Properties
    var showProfileView: Bool = false
    var tabProfileRect: CGRect = .zero
    var watchingPrfile: Profile?
    var animateProfile: Bool = false
}
