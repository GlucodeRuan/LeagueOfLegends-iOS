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
    @Published var picker: ListPicker = .champions
    @Published var searchText: String = ""
    
    func searched(championList: [Champion]) -> [Champion] {
        if searchText.isEmpty {
            return championList
        } else {
            return championList.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
    
    func searchedItems(itemList: [Item]) -> [Item] {
        if searchText.isEmpty {
            return itemList
        } else {
            return itemList.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
}
