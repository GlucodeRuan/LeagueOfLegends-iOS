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
        if searchText.isEmpty {
            return dataStore.champions
        } else {
            return dataStore.champions.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
    
    func searchedItems() -> [ItemDatum] {
        if searchText.isEmpty {
            return dataStore.items
        } else {
            return dataStore.items.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
}
