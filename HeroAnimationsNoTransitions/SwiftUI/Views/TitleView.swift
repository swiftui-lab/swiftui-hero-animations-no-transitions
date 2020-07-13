//
//  TitleView.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

struct TitleView: View {
    @State private var slowAnimations: Bool = debugAnimations

    var body: some View {
        let debug = Binding<Bool>(get: { slowAnimations }, set: { slowAnimations = $0; debugAnimations = $0 })

        return VStack(alignment: .leading) {
            Text("Wildlife Encyclopedia").font(.largeTitle).fontWeight(.bold)
            
            HStack {
                Text("Double tap to select favorites").font(.subheadline).foregroundColor(Color(UIColor.secondaryLabel))
                
                if debug.wrappedValue {
                    Text("Slow Animations On").font(.caption).foregroundColor(.white).padding(.horizontal, 5).background(Color.red).opacity(0.7)
                }
            }
        }.onTapGesture {
            withAnimation {                
                debug.wrappedValue.toggle()
            }
        }
    }
}
