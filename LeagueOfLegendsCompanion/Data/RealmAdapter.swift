//
//  RealmAdapter.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/30.
//

import Foundation
import RealmSwift

final class RealmAdapter {
    
    func create() {
        do {
            let realm = try Realm()
            realm.create(Object.self)
        } catch {
            
        }
    }
    
    func read() -> Results<Object>? {
        do {
            let realm = try Realm()
            return realm.objects(Object.self)
        } catch {
            
        }
        return nil
    }
    
    func update(_ model: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(model)
            }
        } catch {
            
        }
    }
    
    func delete(_ model: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(model)
            }
        } catch {
            
        }
    }
}
