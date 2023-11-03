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
        
    @Published var picker: ListPicker = .champions
    @Published var searchText: String = ""
    
    func searchedChampions() -> [Champion] {
        var championList: [Champion] = champions.map({ Champion($0) })
        
        if searchText.isEmpty {
            return championList
        } else {
            return championList.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
    
    func searchedItems() -> [Item] {
        var itemList: [Item] = items.map({ Item($0) })
        
        if searchText.isEmpty {
            return itemList
        } else {
            return itemList.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
}
