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
    @State private var animateToMainView: Bool = false
    
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(animateToCenter ? 0 : 1)
        .background(.black)
        .opacity(animateToMainView ? 0 : 1)
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
                let screenRect = proxy.frame(in: .global)
                
                /// Positions
                let sourcePosition = CGPoint(x: sRect.midX, y: sRect.midY)
                let centerPosition = CGPoint(x: screenRect.width/2, y: (screenRect.height/2)-40)
                let destinationPosition = CGPoint(x: appData.tabProfileRect.midX, y: appData.tabProfileRect.midY)
                let animationPath = Path { path in
                    path.move(to: sourcePosition)
                    path.addLine(to: destinationPosition)
                }
                
                animationPath.stroke(lineWidth: 2)
                                
                /// Selected Profile Image View with Loading Indicator
                ZStack {
                    Image(profile.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: animateToMainView ? 25 : sRect.width, height: animateToMainView ? 25 : sRect.height)
                        .clipShape(.rect(cornerRadius: 10))
                        .position(animateToCenter ? (animateToMainView ? destinationPosition : centerPosition) : sourcePosition)
                    
                    /// Custom Netflix Style Indicator
                    NetflixLoader()
                        .frame(width: 60, height: 60)
                        .offset(y: 80)
                        .opacity(animateToCenter ? 1 : 0)
                    
                }
                .transition(.identity)
                .task {
                    guard !animateToCenter else { return }
                    
                    await animateUser()
                }
            }
        }
    }
    
    
    /// Animate User
    func animateUser() async {
        withAnimation(.bouncy(duration: 0.35)) {
            animateToCenter = true
        }
        
        await loadContents()
        
        withAnimation(.snappy(duration: 0.6, extraBounce: 0.1), completionCriteria: .removed) {
            animateToMainView = true
        } completion: { }

    }
    
    
    /// Load Contents
    func loadContents() async {
        /// Load Any Network Content Here
        try? await Task.sleep(for: .seconds(1))
    }
    
    
    /// Profile Card View
    @ViewBuilder func ProfileCardview(_ profile: Profile) -> some View {
        VStack(spacing: 8) {
            let status = profile.id == appData.watchingPrfile?.id
            
            GeometryReader { _ in
                Image(profile.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                    .opacity(animateToCenter ? 0 : 1)
            }
            .animation(status ? .none : .bouncy(duration: 0.35), value: animateToCenter)
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
    ContentView()
}
