//
//  ChampionDetailView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI
import Kingfisher

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

                KFImage(viewModel.fetchChampImage(for: .splash))
                    .resizable()
                    .onProgress({ receivedSize, totalSize in
                        loading = true
                    })
                    .onSuccess({ result in
                        loading = false
                    })
                    .onFailureImage(KFCrossPlatformImage(systemName: "wifi.slash"))
                    .onFailure({ error in
                        loading = false
                        print(error)
                    })
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Class")
                        .font(.headline)
//                    ForEach(viewModel.champion.tags, id:\.rawValue) { tag in
//                        Text("• \(tag.rawValue)")
//                            .font(.footnote)
//                            .foregroundColor(.secondary)
//                        
//                    }
                }
                .padding(.bottom)
                
                Divider()
                
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
//                    Text("Consumption type: \(viewModel.champion.partype)")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
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
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Stats")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 0) {
//                        ForEach(Array(viewModel.champion.stats), id: \.key) { key, value in
//                            Text("\(key): \(String(format: "%g", value))")
//                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.bottom)
                
                Spacer()
            }
            .padding()
        }
        .redacted(reason: loading ? .placeholder : [])
    }
}
