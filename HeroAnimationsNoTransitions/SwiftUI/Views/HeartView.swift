//
//  HeartView.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

struct HeartView: View {
    let isFavorite: Bool
    
    var body: some View {
        if isFavorite {
            Image(systemName: "star.fill")
                .shadow(radius: 3)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(20)
        }

    }
}
