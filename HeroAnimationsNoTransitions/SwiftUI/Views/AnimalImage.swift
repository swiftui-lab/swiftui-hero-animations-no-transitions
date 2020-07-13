//
//  AnimalImage.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

struct AnimalImage: View {
    @Environment(\.gridRadiusPct) var radiusPercent: CGFloat
    @Environment(\.gridShadow) var shadowRadius: CGFloat

    let image: String
    let favorite: Bool
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .clipShape(RectangleToCircle(cornerRadiusPercent: radiusPercent))
            .shadow(radius: shadowRadius)
            .overlay(StarView(isFavorite: favorite), alignment: .topTrailing)
    }
}
