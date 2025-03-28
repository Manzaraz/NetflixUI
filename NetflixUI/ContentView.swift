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
            MainView()
            
            if appData.showProfileView {
                Rectangle()
                    .fill(.black)
                    .ignoresSafeArea()
                    .transition(.identity)
            }
            
            ZStack {
                if appData.showProfileView {
                    ProfileView()
                }
            }
            .animation(.snappy, value: appData.showProfileView)
            
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
