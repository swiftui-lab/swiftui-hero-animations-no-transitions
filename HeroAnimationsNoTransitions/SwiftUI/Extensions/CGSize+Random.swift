//
//  UsefulExensions.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

extension CGSize {
    static func random(width: ClosedRange<CGFloat>, height: ClosedRange<CGFloat>) -> CGSize {
        return CGSize(width: CGFloat.random(in: width), height: CGFloat.random(in: height))
    }
    
    static func random(in range: ClosedRange<CGFloat>) -> CGSize {
        return CGSize(width: CGFloat.random(in: range), height: CGFloat.random(in: range))
    }
}
