//
//  FavoriteView.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

struct FavoriteView: View {
    let image: String
    var pct: CGFloat
    
    var body: some View {
        // We use EmptyView, because the modifier actually ignores
        // the value passed to its body() function.
        EmptyView().modifier(FavoriteMod(image: image, pct: pct))
    }
}

struct FavoriteMod: AnimatableModifier {
    @Environment(\.favRadiusPct) var favRadiusPct: CGFloat
    @Environment(\.favShadow) var favShadow: CGFloat

    @Environment(\.gridRadiusPct) var gridRadiusPct: CGFloat
    @Environment(\.gridShadow) var gridShadow: CGFloat

    let image: String
    var pct: CGFloat
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        let radiusPercent = (favRadiusPct - gridRadiusPct) * pct + gridRadiusPct
        let shadow = (favShadow - gridShadow) * pct + gridShadow
        
        return Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RectangleToCircle(cornerRadiusPercent: radiusPercent))
            .overlay(RectangleToCircle(cornerRadiusPercent: radiusPercent).stroke(Color.white, lineWidth: 2 * pct))
            .padding(2 * pct)
            .overlay(RectangleToCircle(cornerRadiusPercent: radiusPercent).strokeBorder(Color.black.opacity(0.1 * Double(pct))))
            .shadow(radius: shadow)
            .padding(4 * pct)
    }
}
