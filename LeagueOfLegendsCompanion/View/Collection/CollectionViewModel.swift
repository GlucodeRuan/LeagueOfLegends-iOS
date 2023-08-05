//
//  ListViewModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation

enum ListPicker: String, CaseIterable {
    case champions
    case items
}

@MainActor
final class CollectionViewModel: ObservableObject {
    let dataStore = DataStoreHandler.shared
    
    @Published var searchText: String = ""
    @Published var picker: ListPicker = .champions
    
    func searchedChampions() -> [ChampDatum] {
        let sortedChampions = dataStore.champions.sorted(by: { $0.name < $1.name })
        if searchText.isEmpty {
            return sortedChampions
        } else {
            return sortedChampions.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
    
    func searchedItems() -> [ItemDatum] {
        let filteredItems = dataStore.items.filter { !$0.name.contains("<") }
        let sortedItems = filteredItems.sorted(by: { $0.name < $1.name })
        if searchText.isEmpty {
            return sortedItems
        } else {
            return sortedItems.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
}
