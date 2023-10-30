//
//  DataStoreHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation
import RealmSwift

final class DataStoreHandler: ObservableObject {
    
    private let gateway: Gateway = Gateway()
    private let realmAdapter: RealmAdapter = RealmAdapter()
        
    func checkVersion() {
        gateway.fetchVersions { versionData, error in
            if let versionData {
                let usableVersions = versionData.versions.filter({ !$0.lowercased().contains("lolpatch_")})
                let sortedVersions = usableVersions.sorted()
                let latestVersion = sortedVersions.last!
                if latestVersion > self.version.latestVersion {
                    
                    self.updateVersionModel(with: sortedVersions)
                    
                    self.gateway.fetchItems(for: latestVersion) { data, error in
                        guard let usableData = data?.data.map({ $0.value }) else { return }
                        let sortedData = usableData.sorted(by: { $0.name < $1.name })
                        let filtededData = sortedData.filter { !$0.name.contains("<") }
                        self.updateItemModel(with: filtededData)
                    }
                    self.gateway.fetchChampions(for: latestVersion) { data, error in
                        guard let usableData = data?.data.map({ $0.value }) else { return }
                        let sortedData = usableData.sorted(by: { $0.name < $1.name })
                        self.updateChampionModel(with: sortedData)
                    }
                }
            }
        }
    }
    
    private func updateVersionModel(with data: [String]) {
        let model = VersionModel(data)
        
        realmAdapter.create()
        realmAdapter.update(model)
    }

    private func updateChampionModel(with data: [ChampDatum]) {
        for datum in data {
            let model = ChampionModel(name: datum.name,
                                          blurb: datum.blurb,
                                          attack: datum.info.attack,
                                          defense: datum.info.defense,
                                          magic: datum.info.magic,
                                          difficulty: datum.info.difficulty,
                                          image: datum.image.full,
                                          title: datum.title)
            realmAdapter.create()
            realmAdapter.update(model)
        }
    }
    
    private func updateItemModel(with data: [ItemDatum]) {
        for datum in data {
            let model = ItemModel(name: datum.name,
                                  image: datum.image.full,
                                  basePrice: datum.gold.base,
                                  sellPrice: datum.gold.sell,
                                  itemDescription: datum.description,
                                  colloq: datum.colloq,
                                  plaintext: datum.plaintext,
                                  stacks: datum.stacks)
            
            realmAdapter.create()
            realmAdapter.update(model)
        }
    }
}
