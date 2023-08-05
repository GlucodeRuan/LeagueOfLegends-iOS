//
//  ListView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel: ListViewModel = ListViewModel()
    var body: some View {
        NavigationStack {
            List(Array(viewModel.searchedList()), id: \.self) { champion in
                NavigationLink(value: champion) {
                    Text(champion.name)
                }
            }
            .navigationDestination(for: Datum.self) { champion in
                ChampionDetailView(champion: champion)
            }
            .navigationTitle("Champions")
        }
        .tint(.primary)
        .searchable(text: $viewModel.searchText)
        .task {
            await viewModel.fetchChampions()
        }
        .refreshable {
            await viewModel.fetchChampions()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
