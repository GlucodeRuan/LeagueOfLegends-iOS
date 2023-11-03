//
//  DataStoreHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation
import RealmSwift
import Combine

final class DataStoreHandler: ObservableObject {
    
    private let gateway: Gateway
    
    init() {
        self.gateway = Gateway()
    }
    
    func checkVersion() {
        gateway.fetchVersions { versionData in
            if let versionData {
                let usableVersions = versionData.versions.filter({ !$0.lowercased().contains("lolpatch_")})
                let latestVersion = usableVersions.first!
                
                self.updateVersionModel(with: usableVersions)
                self.fetchItems(for: latestVersion)
                self.fetchChampions(for: latestVersion)
            }
        }
    }
    
    private func fetchItems(for version: String) {
        self.gateway.fetchItems(for: version) { data in
            if let usableData = data?.data.map({ $0.value }).unique() {
                let sortedData = usableData.sorted(by: { $0.name < $1.name })
                let filtededData = sortedData.filter { !$0.name.contains("<") }
                self.updateItemModel(with: filtededData)
            }
        }
    }
    
    private func fetchChampions(for version: String) {
        self.gateway.fetchChampions(for: version) { data in
            if let usableData = data?.data.map({ $0.value }).unique() {
                let sortedData = usableData.sorted(by: { $0.name < $1.name })
                self.updateChampionModel(with: sortedData)
            }
        }
    }
    
    private func updateVersionModel(with data: [String]) {
        // update realm model
    }
    
    private func updateChampionModel(with data: [ChampDatum]) {
        // update realm model
    }
    
    func updateItemModel(with data: [ItemDatum]) {
        // update realm model
    }
}
