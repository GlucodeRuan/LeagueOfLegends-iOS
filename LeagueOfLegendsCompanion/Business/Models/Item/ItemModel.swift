//
//  ItemModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/29.
//

import Foundation
import RealmSwift

final class ItemModel: Object, ObjectKeyIdentifiable, RealmAdaptable {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var name: String = ""
    @Persisted var image: String = ""
    @Persisted var basePrice: Int = 0
    @Persisted var sellPrice: Int = 0
    @Persisted var itemDescription: String = ""
    @Persisted var colloq: String = ""
    @Persisted var plaintext: String = ""
    @Persisted var stacks: Int? = nil
    @Persisted var stats: Map<String, Double>

    convenience init(_ model: Item) {
        self.init()

        self.name = model.name
        self.image = model.image
        self.basePrice = model.basePrice
        self.sellPrice = model.sellPrice
        self.itemDescription = model.itemDescription
        self.colloq = model.colloq
        self.plaintext = model.plaintext
        self.stacks = model.stacks

        self.updateStats(model)
    }

    private func updateStats(_ model: Item) {
        let stats = model.stats

        for stat in stats {
            self.stats.setValue(stat.value, forKey: stat.key)
        }
    }
}

