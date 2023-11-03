//
//  ItemDetailView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI
import Kingfisher

struct ItemDetailView: View {
    @StateObject var viewModel: ItemDetailViewModel
    @State var loading: Bool = true

    init(item: Item) {
        self._viewModel = StateObject(wrappedValue: ItemDetailViewModel(item: item))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    AsyncImage(url: viewModel.fetchItemImage()) { image in
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

                VStack(alignment: .leading, spacing: 8) {
                    
                    VStack(alignment: .leading, spacing: 0) {
//                        ForEach(Array(viewModel.item.stats), id: \.key) { key, value in
//                            Text("\(key): \(String(format: "%g", value))")
//                        }
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
