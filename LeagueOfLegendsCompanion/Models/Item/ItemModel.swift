//
//  ItemModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/29.
//

import Foundation
import RealmSwift

final class ItemModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var basePrice: Int
    @Persisted var sellPrice: Int
    @Persisted var itemDescription: String
    @Persisted var colloq: String
    @Persisted var plaintext: String
    @Persisted var stacks: Int?
//    @Persisted var stats: [String: Int]
    
    convenience init(_ model: ItemModel) {
        self.init()

        self.name = model.name
        self.image = model.image
        self.basePrice = model.basePrice
        self.sellPrice = model.sellPrice
        self.itemDescription = model.itemDescription
        self.colloq = model.colloq
        self.plaintext = model.plaintext
        self.stacks = model.stacks
    }
    
    init(name: String, image: String, basePrice: Int, sellPrice: Int, itemDescription: String, colloq: String, plaintext: String, stacks: Int?) {
        self.name = name
        self.image = image
        self.basePrice = basePrice
        self.sellPrice = sellPrice
        self.itemDescription = itemDescription
        self.colloq = colloq
        self.plaintext = plaintext
        self.stacks = stacks
    }
    
    func create() {
        do {
            let realm = try Realm()
            realm.create(ItemModel.self)
        } catch {
            
        }
    }
    
    func read() -> Results<ItemModel>? {
        do {
            let realm = try Realm()
            return realm.objects(ItemModel.self)
        } catch {
            
        }
        return nil
    }
    
    func update(_ model: ItemModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(model)
            }
        } catch {
            
        }
    }
    
    func delete(_ model: ItemModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(model)
            }
        } catch {
            
        }
    }
}

