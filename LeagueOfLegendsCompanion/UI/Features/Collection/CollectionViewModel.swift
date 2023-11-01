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
    
    func searchedChampions() -> [Champion] {
        var champions: [Champion] = []
        
        for champion in self.champions {
            champions.append(Champion(champion))
        }
        
        if searchText.isEmpty {
            return champions
        } else {
            return champions.filter({ $0.name.lowercased().contains(searchText.lowercased())
            })
        }
    }
    
    func searchedItems() -> [Item] {
        var items: [Item] = []
        
        for item in self.items {
            items.append(Item(item))
        }
        
        if searchText.isEmpty {
            return items
        } else {
            return items.filter({ $0.name.lowercased().contains(searchText.lowercased())
            })
        }
    }
}
