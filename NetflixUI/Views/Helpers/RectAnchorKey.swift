//
//  RectAnchorKey.swift
//  NetflixUI
//
//  Created by Christian Manzaraz on 27/03/2025.
//

import SwiftUI

struct RectAnchorKey: PreferenceKey {
    static var defaultValue = [String: Anchor<CGRect>]()
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
    
}

