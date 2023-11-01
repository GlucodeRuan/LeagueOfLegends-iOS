//
//  DataStoreHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation
import RealmSwift
import Combine

enum AlertMessages: String {
    case initializing
    case updating
    case updated
    case disconnected
}

final class DataStoreHandler: ObservableObject {
    
//    @Published var alertMessage: String?
    
    private let gateway: Gateway
    
    init() {
        self.gateway = Gateway()
    }

    func checkVersion(completion: @escaping (String?) -> Void) {
        gateway.fetchVersions { versionData, error in
            if let versionData {
                let usableVersions = versionData.versions.filter({ !$0.lowercased().contains("lolpatch_")})
                let latestVersion = usableVersions.first!
                if let persistedVersion = VersionModel().read(key: "singleton") {
                    if latestVersion != persistedVersion.latestVersion {
                        completion(AlertMessages.updating.rawValue)
                        self.updateVersionModel(with: usableVersions)
                        self.fetchItems(for: latestVersion)
                        self.fetchChampions(for: latestVersion)
                    } else {
                        completion(AlertMessages.updated.rawValue)
                    }
                } else {
                    completion(AlertMessages.initializing.rawValue)
                    var firstVersionList: [String] = []
                    firstVersionList.append(latestVersion)
                    self.updateVersionModel(with: firstVersionList)
                    self.fetchItems(for: latestVersion)
                    self.fetchChampions(for: latestVersion)
                }
            } else {
                completion(AlertMessages.disconnected.rawValue)
            }
        }
    }
    
    private func fetchItems(for version: String) {
        self.gateway.fetchItems(for: version) { data, error in
            guard let usableData = data?.data.map({ $0.value }).unique() else { return }
            let sortedData = usableData.sorted(by: { $0.name < $1.name })
            let filtededData = sortedData.filter { !$0.name.contains("<") }
            self.updateItemModel(with: filtededData)
        }
    }
    
    private func fetchChampions(for version: String) {
        self.gateway.fetchChampions(for: version) { data, error in
            guard let usableData = data?.data.map({ $0.value }).unique() else { return }
            let sortedData = usableData.sorted(by: { $0.name < $1.name })
            self.updateChampionModel(with: sortedData)
        }
    }
    
    private func updateVersionModel(with data: [String]) {
        let model = VersionModel(data)
        VersionModel().update(model)
    }
    
    private func updateChampionModel(with data: [ChampDatum]) {
        for datum in data {
            let champion = Champion(image: datum.image.full, name: datum.name,
                                    title: datum.title, blurb: datum.blurb,
                                    attack: datum.info.attack,
                                    defense: datum.info.defense,
                                    magic: datum.info.magic,
                                    difficulty: datum.info.difficulty)
            
            let model = ChampionModel(champion)
            ChampionModel().update(model)
        }
    }
    
    func updateItemModel(with data: [ItemDatum]) {
        for datum in data {
            let item = Item(name: datum.name,
                            image: datum.image.full,
                            basePrice: datum.gold.base,
                            sellPrice: datum.gold.sell,
                            itemDescription: datum.description,
                            colloq: datum.colloq,
                            plaintext: datum.plaintext,
                            stacks: datum.stacks)
            
            let model = ItemModel(item)
            ItemModel().update(model)
        }
    }
}
