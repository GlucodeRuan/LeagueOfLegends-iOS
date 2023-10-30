//
//  ChampionModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/29.
//

import Foundation
import RealmSwift

final class ChampionModel: Object, ObjectKeyIdentifiable {
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
    
    override convenience init() {
        self.init()

        self.name = ""
        self.blurb = ""
        self.attack = 0
        self.defense = 0
        self.magic = 0
        self.difficulty = 0
        self.image = ""
        self.title = ""
    }
    
    init(name: String, blurb: String, attack: Int, defense: Int, magic: Int, difficulty: Int, image: String, title: String) {
        self.name = name
        self.blurb = blurb
        self.attack = attack
        self.defense = defense
        self.magic = magic
        self.difficulty = difficulty
        self.image = image
        self.title = title
    }
    
    func create() {
        do {
            let realm = try Realm()
            realm.create(ChampionModel.self)
        } catch {
            
        }
    }
    
    func read() -> Results<ChampionModel>? {
        do {
            let realm = try Realm()
            return realm.objects(ChampionModel.self)
        } catch {
            
        }
        return nil
    }
    
    func update(_ model: ChampionModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(model)
            }
        } catch {
            
        }
    }
    
    func delete(_ model: ChampionModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(model)
            }
        } catch {
            
        }
    }
}

