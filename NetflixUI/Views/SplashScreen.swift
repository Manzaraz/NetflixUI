//
//  SplashScreen.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 26/03/2025.
//

import SwiftUI
import Lottie

struct SplashScreen: View {
    @Environment(AppData.self) private var appData
    
    @State private var progress: CGFloat = 0.0
    
    private var jsonURL: URL? {
        if let bundlePath = Bundle.main.path(forResource: "Logo", ofType: "json") {
            return URL(filePath: bundlePath)
        }
        
        return nil
    }
    
    var body: some View {
        Rectangle()
            .fill(.black)
            .overlay {
                if let jsonURL {
                    LottieView {
                        await LottieAnimation.loadedFrom(url: jsonURL)
                    }
                    .playing(.fromProgress(0, toProgress: progress, loopMode: .playOnce))
                    .animationDidFinish{ completed in
                        appData.isSplashFinished = progress != 0 && completed
                    }
                    .frame(width: 600, height: 400) // The size 600x400 works for all screen sizes (larger to smaller phones)
                    .task {
                        try? await Task.sleep(for: .seconds(0.15))
                        progress = 1.0
                    }
                }
                
            }
            .ignoresSafeArea()
        
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
