//
//  Champion.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/29.
//

import Foundation

struct Champion: Hashable {
    let id = UUID()
    var name: String
    var blurb: String
    var attack: Int
    var defense: Int
    var magic: Int
    var difficulty: Int
    var image: String
    var title: String
    
    init(_ model: ChampionModel) {
        self.name = model.name
        self.blurb = model.blurb
        self.attack = model.attack
        self.defense = model.defense
        self.magic = model.magic
        self.difficulty = model.difficulty
        self.image = model.image
        self.title = model.title
    }
    
    static func == (lhs: Champion, rhs: Champion) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
