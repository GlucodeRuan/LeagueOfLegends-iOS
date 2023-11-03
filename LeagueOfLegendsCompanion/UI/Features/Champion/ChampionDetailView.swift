//
//  ChampionDetailView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

struct ChampionDetailView: View {
    @StateObject var viewModel: ChampionDetailViewModel
    @State var loading: Bool = true
    
    init(champion: Champion) {
        self._viewModel = StateObject(wrappedValue: ChampionDetailViewModel(champion: champion))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(viewModel.champion.name)
                        .font(.title)
                    Text(viewModel.champion.alias.capitalized)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
                .padding(.bottom)
                
            AsyncImage(url: viewModel.fetchChampImage(for: .splash)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                }
                .padding(.bottom)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Origin")
                        .font(.headline)
                    Text(viewModel.champion.origin)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Info")
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Attack: \(viewModel.champion.attack)")
                        Text("Defense: \(viewModel.champion.defense)")
                        Text("Magic: \(viewModel.champion.magic)")
                        Text("Difficulty: \(viewModel.champion.difficulty)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.bottom)
                
                Spacer()
            }
            .padding()
        }
    }
}
