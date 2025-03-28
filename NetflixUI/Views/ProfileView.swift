//
//  ProfileView.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 27/03/2025.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AppData.self) private var appData
    /// View Properties
    @State private var animateToCenter: Bool = false
    
    var body: some View {
        VStack {
            Button("Edit") {
                //
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .overlay {
                Text("Who's Watching?")
                    .font(.title3.bold())
            }
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.fixed(100), spacing: 25), count: 2)) {
                    ForEach(mockProfile) { profile in
                        ProfileCardview(profile)
                    }
                    
                    /// Add Button
                    Button {
                        //
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white.opacity(0.8), lineWidth: 0.8)
                            
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                        .frame(width: 100, height: 100)
                        .contentShape(.rect)
                    }
                }
                .frame(maxHeight: .infinity)
        }
        .padding(15)
        .opacity(appData.watchingPrfile == nil ? 1 : 0)
        .overlayPreferenceValue(RectAnchorKey.self) { value in
            AnimationLayerView(value)
        }
    }
    
    
    /// Profile Animation View
    @ViewBuilder func AnimationLayerView(_ value: [String: Anchor<CGRect>]) -> some View {
        GeometryReader { proxy in
            if let profile = appData.watchingPrfile,
               let sourceAnchor = value[profile.sourceAnchorID],
               appData.animateProfile {
                
                let sRect = proxy[sourceAnchor]
                
                /// Positions
                let sourcePosition = CGPoint(x: sRect.midX, y: sRect.midY)
                
                
                /// Selected Profile Image View with Loading Indicator
                ZStack {
                    Image(profile.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: sRect.width, height: sRect.height)
                        .clipShape(.rect(cornerRadius: 10))
                        .position(sourcePosition)
                }
            }
        }
    }
    
    
    /// Profile Card View
    @ViewBuilder func ProfileCardview(_ profile: Profile) -> some View {
        VStack(spacing: 8) {
            GeometryReader { _ in
                Image(profile.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
            }
            .frame(width: 100, height: 100)
            .anchorPreference(key: RectAnchorKey.self, value: .bounds) { anchor in
                return [profile.sourceAnchorID: anchor]
            }
            .onTapGesture {
                appData.watchingPrfile = profile
                appData.animateProfile = true
            }

            Text(profile.name)
                .fontWeight(.semibold)
                .lineLimit(1)
        }
    }
}

#Preview {
    ProfileView()
        .environment(AppData())
        .preferredColorScheme(.dark)
}
