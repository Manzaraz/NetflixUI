//
//  NoAnimationButtonStyle.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 26/03/2025.
//

import SwiftUI

struct NoAnimationButtonStyle:  ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

