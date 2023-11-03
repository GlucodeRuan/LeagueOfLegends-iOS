//
//  ContentView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/04.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataStore = DataStoreHandler()
    @State var message: String?
    var body: some View {
        TabView {
            CollectionView()
                .tabItem {
                    Label("Collection", systemImage: "backpack")
                }
            PracticeToolView()
                .tabItem {
                    Label("Practice Tool", systemImage: "scope")
                }
        }
        .tint(.primary)
        .onAppear {
            dataStore.checkVersion { message in
                self.message = message
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.message = nil
                }
            }
        }
        .refreshable {
            dataStore.checkVersion() { message in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
