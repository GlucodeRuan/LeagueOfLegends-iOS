//
//  ContentView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/04.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager: DataManager
    @State private var message: String?

    init() {
        self._dataManager = StateObject(wrappedValue: DataManager())
        self.message = nil
    }

    var body: some View {
        TabView {
            CollectionView()
                .tabItem {
                    Label("Collection", systemImage: "backpack")
                }
        }
        .tint(.primary)
        .onAppear {
            dataManager.updateDataIfOutDated { message in
                self.message = message
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.message = nil
                }
            }
        }
        .refreshable {
            dataManager.updateDataIfOutDated() { message in
                self.message = message
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.message = nil
                }
            }
        }
        .overlay(alignment: .top) {
            if let message {
                alertMessage(message)
            }
        }
    }
    
    @ViewBuilder
    private func alertMessage(_ message: String) -> some View {
        Capsule()
            .fill(Color(uiColor: .tertiarySystemBackground))
            .frame(width: 100, height: 50, alignment: .center)
            .overlay {
                Text(message.capitalized)
            }
            .opacity(0.75)
    }
}

#Preview {
    ContentView()
}
