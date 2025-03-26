//
//  MainView.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 26/03/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            /// Custom Tab Bar
            CustomTabBar()
        }
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
