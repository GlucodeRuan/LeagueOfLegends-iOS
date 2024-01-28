//
//  Champion.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/29.
//

import Foundation

struct Champion: Hashable {
    let id = UUID()
    var image: String
    var name: String
    var alias: String
    var origin: String
    var attack: Int
    var defense: Int
    var magic: Int
    var difficulty: Int
    var tags: [String]
    var partype: String
    var stats: [String: Double]

    init(_ model: ChampionModel) {
        self.name = model.name
        self.origin = model.origin
        self.attack = model.attack
        self.defense = model.defense
        self.magic = model.magic
        self.difficulty = model.difficulty
        self.image = model.image
        self.alias = model.alias
        self.tags = [String]()
        self.partype = model.partype
        self.stats = [String: Double]()

        self.updateTags(model)
        self.updateStats(model)
    }

    init(image: String,
         name: String,
         title: String,
         blurb: String,
         attack: Int,
         defense: Int,
         magic: Int,
         difficulty: Int,
         tags: [String],
         partype: String,
         stats: [String: Double]) {
        self.name = name
        self.origin = blurb
        self.attack = attack
        self.defense = defense
        self.magic = magic
        self.difficulty = difficulty
        self.image = image
        self.alias = title
        self.tags = tags
        self.partype = partype
        self.stats = stats
    }

    static func == (lhs: Champion, rhs: Champion) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    private mutating func updateTags(_ model: ChampionModel) {
        self.tags.append(contentsOf: model.tags)
    }

    private mutating func updateStats(_ model: ChampionModel) {
        let stats = model.stats

        for stat in stats {
            self.stats.updateValue(stat.value, forKey: stat.key)
        }
    }
}
