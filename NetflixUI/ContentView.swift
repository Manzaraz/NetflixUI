//
//  ContentView.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 26/03/2025.
//

import SwiftUI

struct ContentView: View {
    var appData: AppData = .init()
    
    var body: some View {
        ZStack {
            /// First View After Splash Screen
            
            
            if !appData.isSplashFinished {
                SplashScreen()
            }
        }
        .environment(appData)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
