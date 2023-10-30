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
    var name: String
    var image: String
    var basePrice: Int
    var sellPrice: Int
    var itemDescription: String
    var colloq: String
    var plaintext: String
    var stacks: Int?
    
    init(_ model: ItemModel) {
        self.name = model.name
        self.image = model.image
        self.basePrice = model.basePrice
        self.sellPrice = model.sellPrice
        self.itemDescription = model.itemDescription
        self.colloq = model.colloq
        self.plaintext = model.plaintext
        self.stacks = model.stacks
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
}
