//
//  Item.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/29.
//

import Foundation
import SwiftUI

struct Item: Codable, Hashable, Transferable {
    var id = UUID()
    var image: String
    var name: String
    var basePrice: Int
    var sellPrice: Int
    var itemDescription: String
    var colloq: String
    var plaintext: String
    var stacks: Int?
    var stats: [String: Double]

    init(_ model: ItemModel) {
        self.name = model.name
        self.image = model.image
        self.basePrice = model.basePrice
        self.sellPrice = model.sellPrice
        self.itemDescription = model.itemDescription
        self.colloq = model.colloq
        self.plaintext = model.plaintext
        self.stacks = model.stacks
        self.stats = [String: Double]()

        self.updateStats(model)
    }
    
    init(name: String, 
         image: String,
         basePrice: Int,
         sellPrice: Int,
         itemDescription: String,
         colloq: String,
         plaintext: String,
         stacks: Int?,
         stats: [String: Double]) {
        self.name = name
        self.image = image
        self.basePrice = basePrice
        self.sellPrice = sellPrice
        self.itemDescription = itemDescription
        self.colloq = colloq
        self.plaintext = plaintext
        self.stacks = stacks
        self.stats = stats
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .shopItem)
    }

    private mutating func updateStats(_ model: ItemModel) {
        let stats = model.stats

        for stat in stats {
            self.stats.updateValue(stat.value, forKey: stat.key)
        }
    }
}
