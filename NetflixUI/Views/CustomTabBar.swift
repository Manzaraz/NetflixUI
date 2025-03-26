//
//  CustomTabBar.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 26/03/2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Environment(AppData.self) private var appData
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Button {
                    //
                } label: {
                    VStack(spacing: 2) {
                        if tab.icon == "Profile" {
                            Image(.iJustine)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .clipShape(.rect(cornerRadius: 4))
                                .frame(width: 35, height: 35)
                        } else {
                            Image(systemName: tab.icon)
                                .font(.title3)
                                .frame(width: 35, height: 35)
                        }
                        
                        Text(tab.rawValue)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .opacity(appData.activeTab == tab ? 1 : 0.6)
                }

            }
        }
    }
}

#Preview {
    MainView()
        .environment(AppData())
        .preferredColorScheme(.dark)
}
