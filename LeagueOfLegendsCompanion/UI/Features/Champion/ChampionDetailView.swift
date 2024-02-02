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
                    .forceRefresh(!loading)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
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
                    Text("Class")
                        .font(.headline)
                    VStack(alignment: .leading) {
                        ForEach(viewModel.champion.tags, id: \.self) { tag in
                            Text("• \(tag)")
                                .font(.subheadline)                                .foregroundColor(.secondary)

                        }
                    }
                }
                .padding(.bottom)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Primary Stats")
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("• Attack: \(viewModel.champion.attack)")
                        Text("• Defense: \(viewModel.champion.defense)")
                        Text("• Magic: \(viewModel.champion.magic)")
                        Text("• Difficulty: \(viewModel.champion.difficulty)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.bottom)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Secondary Stats")
                        .font(.headline)
                    Text("• Consumption type: \(viewModel.champion.partype)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(viewModel.readableStats().sorted {
                            $0.key < $1.key
                        }), id: \.key) { key, value in
                            Text("• \(key): \(String(format: "%g", value))")
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
        .navigationTitle(viewModel.champion.name)
        .navigationBarTitleDisplayMode(.automatic)
        .redacted(reason: loading ? .placeholder : [])
    }
}

#Preview {
    ChampionDetailView(champion: Champion(image: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Evelynn_0.jpg",
                                          name: "Kayn",
                                          title: "the Shadow Reaper",
                                          lore: "A peerless practitioner of lethal shadow magic, Shieda Khis body and mind. There are only two possible outcomes: either Kayn bends the weapon to his will..ayn battles to achieve his true destinyâ€”to one day lead the Order of Shadow into a new era of Ionian supremacy. He wields the sentient darkin weapon Rhaast, undeterred by its creeping corruption of . or the malevolent blade consumes him completely, paving the way for the destruction of all Runeterra.",
                                          attack: 10,
                                          defense: 6,
                                          magic: 1,
                                          difficulty: 8,
                                          tags: ["Fighter",
                                                 "Assassin"],
                                          partype: "Mana",
                                          stats: ["hp": 655,
                                                  "hpperlevel": 109,
                                                  "mp": 410,
                                                  "mpperlevel": 50,
                                                  "movespeed": 340,
                                                  "armor": 38,
                                                  "armorperlevel": 4.5,
                                                  "spellblock": 32,
                                                  "spellblockperlevel": 2.05,
                                                  "attackrange": 175,
                                                  "hpregen": 8,
                                                  "hpregenperlevel": 0.75,
                                                  "mpregen": 11.5,
                                                  "mpregenperlevel": 0.95,
                                                  "crit": 0,
                                                  "critperlevel": 0,
                                                  "attackdamage": 68,
                                                  "attackdamageperlevel": 3.3,
                                                  "attackspeedperlevel": 2.7,
                                                  "attackspeed": 0.669]))
}

