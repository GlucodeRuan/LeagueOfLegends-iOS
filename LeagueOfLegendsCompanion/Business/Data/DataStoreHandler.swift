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
    case alreadyUpdated
    case disconnected
}

final class DataStoreHandler: ObservableObject {
    private let gateway: Gateway
    
    init() {
        self.gateway = Gateway()
    }
    
    func updateDataIfOutDated(completion: @escaping (String?) -> Void) {
        gateway.fetchVersions { versionData, networkError, dataError in
            if let versionData {
                let usableVersions = versionData.versions.filter({ !$0.lowercased().contains("lolpatch_")})
                let latestVersion = usableVersions.first!
                if let persistedVersion = VersionModel().read(key: "singleton") {
                    if latestVersion != persistedVersion.latestVersion {
                        completion(AlertMessages.updating.rawValue)
                        self.updateVersionModel(with: usableVersions)
                        self.persistItems(for: latestVersion) { error in
                            completion(error)
                        }
                        self.persistChampions(for: latestVersion) { error in
                            completion(error)
                        }
                    } else {
                        completion(AlertMessages.alreadyUpdated.rawValue.addSpacesToCaps().lowercased())
                    }
                } else {
                    completion(AlertMessages.initializing.rawValue)
                    var firstVersionList: [String] = []
                    firstVersionList.append(latestVersion)
                    self.updateVersionModel(with: firstVersionList)
                    self.persistItems(for: latestVersion) { error in
                        completion(error)
                    }
                    self.persistChampions(for: latestVersion) { error in
                        completion(error)
                    }
                }
            } else if let networkError {
                completion(networkError.rawValue)
            } else if let dataError {
                completion(dataError.rawValue)
            }
        }
    }

    private func persistItems(for version: String, completion: @escaping (String?) -> Void) {
        self.gateway.fetchItems(for: version) { data, networkError, dataError in
            if let usableData = self.formatItemData(data) {
                self.updateItemModel(with: usableData)
            } else if let networkError {
                completion(networkError.rawValue)
            } else if let dataError {
                completion(dataError.rawValue)
            }
        }
    }
    
    private func persistChampions(for version: String, completion: @escaping (String?) -> Void) {
        self.gateway.fetchChampions(for: version) { data, networkError, dataError in
            if let usableData = self.formatChampionData(data) {
                self.updateChampionModel(with: usableData)
            } else if let networkError {
                completion(networkError.rawValue)
            } else if let dataError {
                completion(dataError.rawValue)
            }
        }
    }

    private func formatChampionData(_ data: ChampionData?) -> [ChampDatum]? {
        let usableData = data?.data.map({ $0.value }).unique()
        let sortedData = usableData?.sorted(by: { $0.name < $1.name })
        return sortedData
    }

    private func formatItemData(_ data: ItemData?) -> [ItemDatum]? {
        let usableData = data?.data.map({ $0.value }).unique()
        let sortedData = usableData?.sorted(by: { $0.name < $1.name })
        let filtededData = sortedData?.filter { !$0.name.contains("<") }
        return filtededData
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
                                    difficulty: datum.info.difficulty,
                                    tags: datum.tags.map { $0.rawValue }, 
                                    partype: datum.partype,
                                    stats: datum.stats
            )

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
                            stacks: datum.stacks, 
                            stats: datum.stats)

            let model = ItemModel(item)
            ItemModel().update(model)
        }
    }
}
