//
//  RealmAdapter.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/30.
//

import Foundation
import RealmSwift

enum RealmAdapterError: String {
    case createError
    case readError
    case updateError
    case deleteError
}

protocol RealmAdaptable {
    func create()
    func read<KeyType>(key: KeyType) -> Self?
//    func read() -> Results<Self>?
    func update(_ model: Object)
    func delete(_ model: Object)
    func deleteAll()
}

extension RealmAdaptable where Self: Object {
    func create() {
        do {
            let realm = try Realm()
            realm.create(Self.self)
        } catch {
        }
    }
    
    func read<KeyType>(key: KeyType) -> Self? {
        do {
            let realm = try Realm()
            return realm.object(ofType: Self.self, forPrimaryKey: key)
        } catch {
        }
        return nil
    }
    
    func read() -> Results<Self>? {
        do {
            let realm = try Realm()
            return realm.objects(Self.self)
        } catch {
        }
        return nil
    }
    
    func update(_ model: Object) {
        do {
            let realm = try Realm()
            try realm.write {
//                realm.add(model)
                realm.add(model, update: .modified)
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
    
    func deleteAll() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
        }
    }
}
