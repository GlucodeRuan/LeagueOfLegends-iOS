// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let itemData = try? JSONDecoder().decode(ItemData.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - ItemData
struct ItemData: Codable {
    let type: ItemTypeEnum
    let version: String
    let basic: Basic
    let data: [String: ItemDatum]
    let groups: [Group]
    let tree: [Tree]
}

// MARK: - Basic
struct Basic: Codable {
    let name: String
    let rune: Rune
    let gold: Gold
    let group, description, colloq, plaintext: String
    let consumed: Bool
    let stacks, depth: Int
    let consumeOnFull: Bool
//    let from, into: [JSONAny]
    let specialRecipe: Int
    let inStore, hideFromAll: Bool
    let requiredChampion, requiredAlly: String
    let stats: [String: Int]
//    let tags: [JSONAny]
    let maps: [String: Bool]
}

// MARK: - Gold
struct Gold: Codable {
    let base, total, sell: Int
    let purchasable: Bool
}

// MARK: - Rune
struct Rune: Codable {
    let isrune: Bool
    let tier: Int
    let type: String
}

// MARK: - Datum
struct ItemDatum: Codable, Hashable {
    let name, description, colloq, plaintext: String
    let into: [String]?
    let image: ItemImage
    let gold: Gold
    let tags: [ItemTag]
    let maps: [String: Bool]
    let stats: [String: Double]
    let effect: Effect?
    let inStore: Bool?
    let from: [String]?
    let depth: Int?
    let consumed: Bool?
    let stacks: Int?
    let hideFromAll, consumeOnFull: Bool?
    let requiredChampion: String?
    let requiredAlly: RequiredAlly?
    let specialRecipe: Int?
    
    static func == (lhs: ItemDatum, rhs: ItemDatum) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

// MARK: - Effect
struct Effect: Codable {
    let effect1Amount: String
    let effect2Amount, effect3Amount, effect4Amount, effect5Amount: String?
    let effect6Amount, effect7Amount, effect8Amount, effect9Amount: String?
    let effect10Amount, effect11Amount, effect12Amount, effect13Amount: String?
    let effect14Amount, effect15Amount, effect16Amount, effect17Amount: String?
    let effect18Amount: String?

    enum CodingKeys: String, CodingKey {
        case effect1Amount = "Effect1Amount"
        case effect2Amount = "Effect2Amount"
        case effect3Amount = "Effect3Amount"
        case effect4Amount = "Effect4Amount"
        case effect5Amount = "Effect5Amount"
        case effect6Amount = "Effect6Amount"
        case effect7Amount = "Effect7Amount"
        case effect8Amount = "Effect8Amount"
        case effect9Amount = "Effect9Amount"
        case effect10Amount = "Effect10Amount"
        case effect11Amount = "Effect11Amount"
        case effect12Amount = "Effect12Amount"
        case effect13Amount = "Effect13Amount"
        case effect14Amount = "Effect14Amount"
        case effect15Amount = "Effect15Amount"
        case effect16Amount = "Effect16Amount"
        case effect17Amount = "Effect17Amount"
        case effect18Amount = "Effect18Amount"
    }
}

// MARK: - Image
struct ItemImage: Codable {
    let full: String
    let sprite: ItemSprite
    let group: ItemTypeEnum
    let x, y, w, h: Int
}

enum ItemTypeEnum: String, Codable {
    case item = "item"
}

enum ItemSprite: String, Codable {
    case item0PNG = "item0.png"
    case item1PNG = "item1.png"
    case item2PNG = "item2.png"
    case item3PNG = "item3.png"
    case item4PNG = "item4.png"
}

enum RequiredAlly: String, Codable {
    case ornn = "Ornn"
}

enum ItemTag: String, Codable {
    case abilityHaste = "AbilityHaste"
    case active = "Active"
    case armor = "Armor"
    case armorPenetration = "ArmorPenetration"
    case attackSpeed = "AttackSpeed"
    case aura = "Aura"
    case boots = "Boots"
    case consumable = "Consumable"
    case cooldownReduction = "CooldownReduction"
    case criticalStrike = "CriticalStrike"
    case damage = "Damage"
    case goldPer = "GoldPer"
    case health = "Health"
    case healthRegen = "HealthRegen"
    case jungle = "Jungle"
    case lane = "Lane"
    case lifeSteal = "LifeSteal"
    case magicPenetration = "MagicPenetration"
    case magicResist = "MagicResist"
    case mana = "Mana"
    case manaRegen = "ManaRegen"
    case nonbootsMovement = "NonbootsMovement"
    case onHit = "OnHit"
    case slow = "Slow"
    case spellBlock = "SpellBlock"
    case spellDamage = "SpellDamage"
    case spellVamp = "SpellVamp"
    case stealth = "Stealth"
    case tenacity = "Tenacity"
    case trinket = "Trinket"
    case vision = "Vision"
}

// MARK: - Group
struct Group: Codable {
    let id, maxGroupOwnable: String

    enum CodingKeys: String, CodingKey {
        case id
        case maxGroupOwnable = "MaxGroupOwnable"
    }
}

// MARK: - Tree
struct Tree: Codable {
    let header: String
    let tags: [String]
}
