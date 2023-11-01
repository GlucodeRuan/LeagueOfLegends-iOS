//
//  ListView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var dataStore: DataStoreHandler
    @StateObject var viewModel: CollectionViewModel = CollectionViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $viewModel.picker) {
                    ForEach(ListPicker.allCases, id: \.self) { pick in
                        Text(pick.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                switch viewModel.picker {
                case .champions:
                    List(Array(viewModel.searchedChampions()), id: \.self) { champion in
                        NavigationLink(value: champion) {
                            Text(champion.name)
                        }
                    }
                    .navigationDestination(for: Champion.self) { champion in
                        ChampionDetailView(champion: champion)
                    }
                case .items:
                    List(Array(viewModel.searchedItems()), id: \.self) { item in
                        NavigationLink(value: item) {
                            Text(item.name)
                        }
                    }
                    .navigationDestination(for: Item.self) { item in
                        ItemDetailView(item: item)
                    }
                }
            }
            .navigationTitle("Collection")
            .searchable(text: $viewModel.searchText)
//            .task {
//                dataStore.fetchChampions()
//                dataStore.fetchItems()
//            }
//            .refreshable {
//                dataStore.fetchChampions()
//                dataStore.fetchItems()
//            }
            .onDisappear() {
//                dataStore.cancelTasks()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
