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
    @Persisted var image: String = ""
    @Persisted var name: String = ""
    @Persisted var alias: String = ""
    @Persisted var origin: String = ""
    @Persisted var attack: Int  = 0
    @Persisted var defense: Int = 0
    @Persisted var magic: Int = 0
    @Persisted var difficulty: Int = 0
    
    convenience init(_ model: Champion) {
        self.init()
        self.image = model.image
        self.name = model.name
        self.alias = model.alias
        self.origin = model.origin
        self.attack = model.attack
        self.defense = model.defense
        self.magic = model.magic
        self.difficulty = model.difficulty
    }
}
