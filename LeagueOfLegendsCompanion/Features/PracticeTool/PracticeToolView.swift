//
//  PracticeToolView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

struct PracticeToolView: View {
    @EnvironmentObject var dataStore: DataStoreHandler
    @StateObject var viewModel = PracticeToolViewModel()
    @State var isTargeted = false
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
                            ForEach(viewModel.userInverntory, id: \.name) { item in
                                itemCard(item: item)
                            }
                        }
                    }
                    .frame(height: 225)
                    .dropDestination(for: ItemDatum.self) { items, location in
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
                                itemCard(item: item)
                            }
                        }
                    }
                    .frame(height: 225)
                    .dropDestination(for: ItemDatum.self) { items, location in
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
                            ForEach(dataStore.items, id: \.name) { item in
                                itemCard(item: item)
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
    private func itemCard(item: ItemDatum) -> some View {
        VStack {
            AsyncImage(url: viewModel.fetchItemImage(for: item)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 50 ,height: 50)
            } placeholder: {
                ProgressView()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
            }
            .draggable(item)
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Label(String(describing: item.gold.total), systemImage: "g.circle.fill")
                    .font(.footnote)
                    .foregroundColor(.yellow)
                    .padding(.bottom)
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
