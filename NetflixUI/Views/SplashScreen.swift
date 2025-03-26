//
//  SplashScreen.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 26/03/2025.
//

import SwiftUI
import Lottie

struct SplashScreen: View {
    @State private var progress: CGFloat = 0.0
    
    private var jsonURL: URL? {
        if let bundlePath = Bundle.main.path(forResource: "Logo", ofType: "json") {
            return URL(filePath: bundlePath)
        }
        
        return nil
    }
    
    var body: some View {
        
        if let jsonURL {
            LottieView {
                await LottieAnimation.loadedFrom(url: jsonURL)
            }
            .playing(.fromProgress(0, toProgress: progress, loopMode: .playOnce))
            .animationDidFinish{ completed in
                print(completed)
            }
            .task {
                try? await Task.sleep(for: .seconds(0.15))
                progress = 1.0
            }
        }
    }
}

#Preview {
    SplashScreen()
        .preferredColorScheme(.dark)
}
