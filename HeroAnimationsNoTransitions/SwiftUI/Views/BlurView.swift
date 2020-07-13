//
//  BlurView.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

struct BlurView: View {
    @Environment(\.colorScheme) var scheme

    var active: Bool
    var onTap: () -> ()

    var body: some View {
        if active {
            VisualEffectView(uiVisualEffect: UIBlurEffect(style: scheme == .dark ? .dark : .light))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(perform: self.onTap)
        }
    }
}

