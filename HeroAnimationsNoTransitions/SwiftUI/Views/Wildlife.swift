//
//  Wildlife.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

struct Wildlife: View {
    @StateObject private var data = DataModel()
    
    @Namespace private var ns_grid // ids to match grid elements with modal
    @Namespace private var ns_favorites // ids to match favorite icons with modal

    @State private var shake = false
    @State private var blur: Bool = false

    // Tap flags
    @State private var animalDoubleTap: Int? = nil
    @State private var animalTap: Int? = nil
    @State private var favoriteTap: Int? = nil
    
    // Views are matched at insertion, but onAppear we broke the match
    // in order to animate immediately after view insertion
    // These flags control the match/unmatch
    @State private var flyFromGridToFavorite: Bool = false
    @State private var flyFromGridToModal: Bool = false
    @State private var flyFromFavoriteToModal: Bool = false

    // Determine if geometry matches occur
    var matchGridToModal: Bool { !flyFromGridToModal && animalTap != nil }
    var matchFavoriteToModal: Bool { !flyFromGridToModal && favoriteTap != nil }
    func matchGridToFavorite(_ id: Int) -> Bool { animalDoubleTap == id && !flyFromGridToFavorite }

    let c = GridItem(.adaptive(minimum: 200, maximum: 400), spacing: 20)

    var body: some View {
        
        ZStack {
            //-------------------------------------------------------
            // Main View: Title + Favorites + Grid (zIndex = 1)
            //-------------------------------------------------------
            VStack {
                // Header (Title + Favorites)
                HStack(alignment: .center, spacing: -30) {
                    // Title View (top left)
                    TitleView()
                    
                    Spacer()
                    
                    // Favorite Icons (top right)
                    ForEach(data.favorites.reversed()) { item in
                        FavoriteView(image: item.image,
                                     pct: matchGridToFavorite(item.id) ? 0.0 : 1.0)
                            .offset(shake ? CGSize.random(width: 10...40, height: 0...0) : .zero)
                            .matchedGeometryEffect(id: matchGridToFavorite(item.id) ? item.id : -item.id,
                                                   in: ns_grid,
                                                   isSource: false)
                            .matchedGeometryEffect(id: item.id,
                                                   in: ns_favorites,
                                                   isSource: true)
                            .frame(height: 80)
                            .onAppear {
                                withAnimation(.fly) {
                                    flyFromGridToFavorite = true
                                }
                            }
                            .onTapGesture(count: 2) { toggleFavoriteStatus(item) }
                            .onTapGesture(count: 1) { openModal(item, fromGrid: false) }
                    }
                }
                .frame(height: 80)
                .padding(.top, 20)
                .zIndex(1)
                
                Divider()
                
                // Grid of Wildlife
                ScrollView {
                    LazyVGrid(columns: [c], spacing: 20) {
                        ForEach(data.items) { item in
                            AnimalImage(image: item.image, favorite: data.isFavorite(item))
                                .onTapGesture(count: 2) { toggleFavoriteStatus(item) }
                                .onTapGesture(count: 1) { openModal(item, fromGrid: true) }
                                .matchedGeometryEffect(id: item.id, in: ns_grid, isSource: true)
                        }
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .zIndex(1)
            
            //-------------------------------------------------------
            // Backdrop blurred view (zIndex = 2)
            //-------------------------------------------------------
            BlurView(active: blur, onTap: dismissModal)
                .zIndex(2)
            
            //-------------------------------------------------------
            // Modal View (zIndex = 3)
            //-------------------------------------------------------
            if animalTap != nil || favoriteTap != nil {
                ModalView(id: animalTap ?? favoriteTap!,
                          pct: flyFromGridToModal ? 1 : 0,
                          flyingFromGrid: animalTap != nil,
                          onClose: dismissModal)
                    .matchedGeometryEffect(id: matchGridToModal ? animalTap! : 0, in: ns_grid, isSource: false)
                    .matchedGeometryEffect(id: matchFavoriteToModal ? favoriteTap! : 0, in: ns_favorites, isSource: false)
                    .frame(width: 600, height: 600)
                    .onAppear { withAnimation(.fly) { flyFromGridToModal = true } }
                    .onDisappear { flyFromGridToModal = false }
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .move(edge: .bottom)))
                    .environmentObject(data)
                    .zIndex(3)
            }

        }
    }
    
    func dismissModal() {
        withAnimation(.basic) {
            animalTap = nil
            favoriteTap = nil
            blur = false
        }
    }
    
    func openModal(_ item: ItemData, fromGrid: Bool) {
        
        if fromGrid {
            animalTap = item.id
        } else {
            favoriteTap = item.id
        }
        
        withAnimation(.basic) {
            blur = true
        }
    }
    
    func toggleFavoriteStatus(_ item: ItemData) {
        
        if let idx = data.favorites.firstIndex(where: { $0.id == item.id }) {
            // Remove from Favorites
            withAnimation(.basic) {
                _ = data.favorites.remove(at: idx)
            }
            
        } else {
            // Add to Favorites, with shake effect animation
            animalDoubleTap = item.id
            flyFromGridToFavorite = false
            
            DispatchQueue.main.async {
                    data.favorites.append(item)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                        withAnimation(.shake) {
                            shake = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                            withAnimation(.shake) {
                                shake = false
                            }
                        }
                    }
            }
        }
    }
}



