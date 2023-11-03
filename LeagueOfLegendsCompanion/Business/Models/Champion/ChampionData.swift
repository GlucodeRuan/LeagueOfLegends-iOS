//
//  ChampionData.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/04.
//

import Foundation

// MARK: - ChampionData
struct ChampionData: Codable {
    let type: ChampTypeEnum
    let format: String
    let version: Version
    let data: [String: Champion]
}

// MARK: - Champ
struct Champion: Codable, Hashable {
    static func == (lhs: Champion, rhs: Champion) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let version: Version
    let id, key, name, title: String
    let blurb: String
    let info: Info
    let image: ChampionImage
    let tags: [ChampTag]
    let partype: String
    let stats: [String: Double]
}

// MARK: - Image
struct ChampionImage: Codable {
    let full: String
    let sprite: ChampSprite
    let group: ChampTypeEnum
    let x, y, w, h: Int
}

enum ChampTypeEnum: String, Codable {
    case champion = "champion"
}

enum ChampSprite: String, Codable {
    case champion0PNG = "champion0.png"
    case champion1PNG = "champion1.png"
    case champion2PNG = "champion2.png"
    case champion3PNG = "champion3.png"
    case champion4PNG = "champion4.png"
    case champion5PNG = "champion5.png"
}

// MARK: - Info
struct Info: Codable {
    let attack, defense, magic, difficulty: Int
}

enum ChampTag: String, Codable, CaseIterable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}

enum Version: String, Codable {
    case the13211 = "13.21.1"
}

// MARK: - ImageTypes
enum ChampionImageTypes {
    case splash
    case loading
}
