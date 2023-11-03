//
//  PracticeToolView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI
import RealmSwift
import Kingfisher

struct PracticeToolView: View {
    @ObservedResults(ChampionModel.self) var champions
    @ObservedResults(ItemModel.self) var items
    
    @StateObject var viewModel = PracticeToolViewModel()
    @State var isTargeted = false
    @State var loading: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Picker("", selection: $viewModel.playerPicker) {
                    ForEach(PracticeToolPlayerPicker.allCases, id: \.self) { pick in
                        Text(pick.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                
                
                switch viewModel.playerPicker {
                case .user:
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.secondarySystemFill))
                            .shadow(color: isTargeted ? .primary : .clear, radius: 10)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(viewModel.userInverntory, id: \.id) { item in
                                itemCard(item: item, showingText: false)
                            }
                        }
                    }
                    .frame(height: 225)
                    .dropDestination(for: Item.self) { items, location in
                        let totalItems = viewModel.userInverntory + items
                        viewModel.userInverntory = totalItems.unique()
                        return true
                    } isTargeted: { isTargeted in
                        self.isTargeted = isTargeted
                    }
                case .enemy:
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.secondarySystemFill))
                            .opacity(isTargeted ? 0 : 1)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(viewModel.enemyInverntory, id: \.name) { item in
                                itemCard(item: item, showingText: false)
                            }
                        }
                    }
                    .frame(height: 225)
                    .dropDestination(for: Item.self) { items, location in
                        let totalItems = viewModel.enemyInverntory + items
                        viewModel.enemyInverntory = totalItems.unique()
                        return true
                    } isTargeted: { isTargeted in
                        self.isTargeted = isTargeted
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemFill))
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(items, id: \.id) { item in
                                itemCard(item: Item(item))
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: 250)
            }
            .padding()
            .navigationTitle("Practice Tool")
        }
    }
    
    @ViewBuilder
    private func itemCard(item: Item, showingText: Bool? = true) -> some View {
        VStack {
            KFImage(viewModel.fetchItemImage(for: item))
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
                .frame(width: 50 ,height: 50)
                .draggable(item)
            
            if let showingText,
               showingText == true {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Label(String(describing: item.basePrice), systemImage: "g.circle.fill")
                        .font(.footnote)
                        .foregroundColor(.yellow)
                        .padding(.bottom)
                }
            }
        }
        .frame(width: 100 ,height: 100)
    }
}

struct PracticeToolView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeToolView()
    }
}
