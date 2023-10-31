//
//  ChampionModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/29.
//

import Foundation
import RealmSwift

final class ChampionModel: Object, ObjectKeyIdentifiable, RealmAdaptable {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var name: String = ""
    @Persisted var blurb: String = ""
    @Persisted var attack: Int  = 0
    @Persisted var defense: Int = 0
    @Persisted var magic: Int = 0
    @Persisted var difficulty: Int = 0
    @Persisted var image: String = ""
    @Persisted var title: String = ""
    
    convenience init(_ model: Champion) {
        self.init()

        self.name = model.name
        self.blurb = model.blurb
        self.attack = model.attack
        self.defense = model.defense
        self.magic = model.magic
        self.difficulty = model.difficulty
        self.image = model.image
        self.title = model.title
    }
    
    
//
//    init(name: String, blurb: String, attack: Int, defense: Int, magic: Int, difficulty: Int, image: String, title: String) {
//        self.name = name
//        self.blurb = blurb
//        self.attack = attack
//        self.defense = defense
//        self.magic = magic
//        self.difficulty = difficulty
//        self.image = image
//        self.title = title
//    }
}

