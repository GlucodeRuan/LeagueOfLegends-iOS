//
//  ItemDetailView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI
import Kingfisher

struct ItemDetailView: View {
    @StateObject private var viewModel: ItemDetailViewModel
    @State private var loading: Bool = true

    init(item: Item) {
        self._viewModel = StateObject(wrappedValue: ItemDetailViewModel(item: item))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    KFImage(viewModel.fetchItemImage())
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
                        .frame(width: 50 ,height: 50)
                        .padding(.trailing)

                    Text(viewModel.item.name)
                        .font(.title)
                    
                    Spacer()
                }
                .padding(.bottom)
                
                Label(String(describing: viewModel.item.basePrice), systemImage: "g.circle.fill")
                    .foregroundColor(.yellow)
                    .padding(.bottom)
                
                Divider()
                
                Text("Info")
                    .font(.headline)
                    .padding(.bottom)

                Text(viewModel.item.plaintext)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom)

                Text("Stats")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(viewModel.readableStats()), id: \.key) { key, value in
                            Text("• \(key): \(String(format: "%g", value))")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.bottom)
            }
            .padding()
        }
        .redacted(reason: loading ? .placeholder : [])
    }
}

#Preview {
    ItemDetailView(item: Item(name: "Ruby Crystal",
                              image: "1028.png",
                              basePrice: 400,
                              sellPrice: 280,
                              itemDescription: "<mainText><stats><attention>150</attention> Health</stats><br><br></mainText>",
                              colloq: ";red",
                              plaintext: "Increases Health",
                              stacks: nil,
                              stats: ["FlatHPPoolMod": 150]))
}
