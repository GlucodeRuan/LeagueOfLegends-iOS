//
//  ListViewModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation
import RealmSwift

enum ListPicker: String, CaseIterable {
    case champions
    case items
}

@MainActor
final class CollectionViewModel: ObservableObject {
    @ObservedResults(ChampionModel.self) var champions
    @ObservedResults(ItemModel.self) var items
    
    @Published var searchText: String = ""
    @Published var picker: ListPicker = .champions
    
    func searchedChampions() -> Results<ChampionModel> {
        if searchText.isEmpty {
            return champions
        } else {
//            return champions.where({ $0.name.lowercased.contains(searchText.lowercased())
//            })
        }
        return champions
    }
    
    func searchedItems() -> Results<ItemModel> {
        if searchText.isEmpty {
            return items
        } else {
//            return items.where({ $0.name.lowercased.contains(searchText.lowercased())
//            })
        }
        return items
    }
}
