//
//  ChampionDetailView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

struct ChampionDetailView: View {
    @StateObject var viewModel: ChampionDetailViewModel
    
    init(champion: Champion) {
        self._viewModel = StateObject(wrappedValue: ChampionDetailViewModel(champion: champion))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(viewModel.champion.name)
                        .font(.title)
                    Text(viewModel.champion.title.capitalized)
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
                    Text("Class")
                        .font(.headline)
                    ForEach(viewModel.champion.tags, id:\.rawValue) { tag in
                        Text("• \(tag.rawValue)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                    }
                }
                .padding(.bottom)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Origin")
                        .font(.headline)
                    Text(viewModel.champion.blurb)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Info")
                        .font(.headline)
                    Text("Consumption type: \(viewModel.champion.partype)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Attack: \(viewModel.champion.info.attack)")
                        Text("Defense: \(viewModel.champion.info.defense)")
                        Text("Magic: \(viewModel.champion.info.magic)")
                        Text("Difficulty: \(viewModel.champion.info.difficulty)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.bottom)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Stats")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(viewModel.champion.stats), id: \.key) { key, value in
                            Text("\(key): \(String(format: "%g", value))")
                        }
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
