//
//  DataItems.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

struct ItemData: Identifiable {
    let id: Int
    let name: String
    let image: String
    let author: String
    var removed: Bool = false
    var `class`: String
}

class DataModel: ObservableObject {    
    @Published var items = [
        ItemData(id: 1, name: "Elephant", image: "elephant", author: "Mylon Ollila", class: "Mammal"),
        ItemData(id: 2, name: "Cheetah", image: "cheetah", author: "Jean Wimmerlin", class: "Mammal"),
        ItemData(id: 3, name: "Parrot", image: "parrot", author: "Andrew Pons", class: "Aves"),
        ItemData(id: 4, name: "Tiger", image: "tiger", author: "Mike Marrah", class: "Mammal"),
        ItemData(id: 5, name: "Zebra", image: "zebra", author: "Frida Bredesen", class: "Mammal"),
        ItemData(id: 6, name: "Lion", image: "lion", author: "Kazuky Akayashi", class: "Mammal"),
        ItemData(id: 7, name: "Mandarin Fish", image: "mandarin-fish", author: "Dorothea Oldani", class: "Actinopterygii"),
        ItemData(id: 8, name: "Apes", image: "ape", author: "Rob Schreckhise", class: "Mammal"),
        ItemData(id: 9, name: "Peacock", image: "peacock", author: "Zuzanna J", class: "Aves"),
        ItemData(id: 10, name: "Giraffe", image: "giraffe", author: "Charl Durand", class: "Mammal"),
        ItemData(id: 11, name: "Fox", image: "fox", author: "Alexander Andrews", class: "Mammal"),
        ItemData(id: 12, name: "Parrot Couple", image: "parrot-couple", author: "Roi Dimor", class: "Aves"),
        ItemData(id: 14, name: "Polar Bear", image: "polar-bear", author: "Hans Jurgen Mager", class: "Mammal"),
        ItemData(id: 15, name: "Dolphin", image: "dolphin", author: "Adam Berkecz", class: "Mammal"),
        ItemData(id: 16, name: "Raccoon", image: "raccoon", author: "Gary Bendig", class: "Mammal"),
        ItemData(id: 18, name: "Panda Bear", image: "panda-bear", author: "Sid Balachandran", class: "Mammal"),
        ItemData(id: 17, name: "Penguin", image: "penguin", author: "Jay Ruzesky", class: "Aves"),
        ItemData(id: 13, name: "Goldfish", image: "goldfish", author: "Zhengtao Tang", class: "Actinopterygii"),
    ]
    
    @Published var favorites: [ItemData] = []
    
    func isFavorite(_ item: ItemData) -> Bool {
        favorites.contains { $0.id == item.id }
    }
}
