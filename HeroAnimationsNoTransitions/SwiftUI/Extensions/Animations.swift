//
//  Animations.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

var debugAnimations = false

extension Animation {
    static var shake: Animation {
        if debugAnimations {
            return Animation.easeInOut(duration: 3.0)
        } else {
            return Animation.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25)
        }
    }
    
    static var fly: Animation {
        if debugAnimations {
            return Animation.easeInOut(duration: 3.0)
        } else {
            return Animation.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25)
        }
    }
    
    static var basic: Animation {
        if debugAnimations {
            return Animation.easeInOut(duration: 3.0)
        } else {
            return Animation.default
        }
    }
}
