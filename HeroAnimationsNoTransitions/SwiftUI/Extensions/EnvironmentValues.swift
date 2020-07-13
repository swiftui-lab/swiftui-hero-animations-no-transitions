//
//  EnvironmentValues.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

extension EnvironmentValues {
    var gridRadiusPct: CGFloat {
        get { return self[GridRadiusPctKey.self] }
        set { self[GridRadiusPctKey.self] = newValue }
    }
    
    var gridShadow: CGFloat {
        get { return self[GridShadowKey.self] }
        set { self[GridShadowKey.self] = newValue }
    }
    
    var favRadiusPct: CGFloat {
        get { return self[FavRadiusPctKey.self] }
        set { self[FavRadiusPctKey.self] = newValue }
    }
    
    var favShadow: CGFloat {
        get { return self[FavShadowKey.self] }
        set { self[FavShadowKey.self] = newValue }
    }
}


public struct GridRadiusPctKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0.12
}

public struct GridShadowKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 8
}

public struct FavRadiusPctKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 1.0
}

public struct FavShadowKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 3
}

extension View {
    func gridLook(radiusPercent: CGFloat? = nil, shadowRadius: CGFloat? = nil) -> some View {
        Group {
            if let r = radiusPercent, let s = shadowRadius {
                self.environment(\.gridRadiusPct, r).environment(\.gridShadow, s)
            } else if let r = radiusPercent {
                self.environment(\.gridRadiusPct, r)
            } else if let s = shadowRadius {
                self.environment(\.gridShadow, s)
            } else {
                self
            }
        }
    }
    
    func favoriteLook(radiusPercent: CGFloat? = nil, shadowRadius: CGFloat? = nil) -> some View {
        Group {
            if let r = radiusPercent, let s = shadowRadius {
                self.environment(\.favRadiusPct, r).environment(\.favShadow, s)
            } else if let r = radiusPercent {
                self.environment(\.favRadiusPct, r)
            } else if let s = shadowRadius {
                self.environment(\.favShadow, s)
            } else {
                self
            }
        }
    }
}
