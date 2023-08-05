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

class CollectionViewModel: ObservableObject {
    let networkHandler: NetworkHandler = NetworkHandler()
    
    @Published var champions = [ChampDatum]()
    @Published var items = [ItemDatum]()
    @Published var searchText: String = ""
    @Published var picker: ListPicker = .champions
    
    func searchedChampions() -> [ChampDatum] {
        let sortedChampions = champions.sorted(by: { $0.name < $1.name })
        if searchText.isEmpty {
            return sortedChampions
        } else {
            return sortedChampions.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
    
    func searchedItems() -> [ItemDatum] {
        let filteredItems = items.filter { !$0.name.contains("<") }
        let sortedItems = filteredItems.sorted(by: { $0.name < $1.name })
        if searchText.isEmpty {
            return sortedItems
        } else {
            return sortedItems.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
    
    func fetchChampions() async {
        do {
            champions = try await networkHandler.fetchChampionList().map({ $0.value })
        } catch {
            
        }
    }
    
    func fetchItems() async {
        do {
            items = try await networkHandler.fetchItemList().map({ $0.value })
        } catch {
            
        }
    }
}
