//
//  Gateway.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/30.
//

import Foundation

enum DataError: String {
    case unreadable_Data
}

protocol Gateway {
    func fetchPersistedData(completion: @escaping (Bool) -> Void)
}

class VersionGateway: Gateway {
    var version: String?
    var tasks: [Task<Void, Never>]

    init(version: String? = nil) {
        self.version = version
        self.tasks = []
    }

    func fetchPersistedData(completion: @escaping (Bool) -> Void) {
        if let persistedData = VersionModel().read(key: "singleton") {
            completion(false)
        } else {
            fetchData { data, networkError, dataError in
                guard let data else { return }
                self.persist(with: data)
                completion(true)
            }
        }
    }

    func fetchPersistedData(completion: @escaping (VersionModel?, NetworkError?, DataError?) -> Void) {
        if let persistedData = VersionModel().read(key: "singleton") {
            completion(persistedData, nil, nil)
        } else {
            fetchData { data, networkError, dataError in
                guard let data else { return }
                self.persist(with: data)
            }
        }
    }

    func fetchData(completion: @escaping (VersionData?, NetworkError?, DataError?) -> Void) {
        let networkHandler: APIFetchable = VersionAPIFetcher()
        let task = Task {
            do {
                let data = try await networkHandler.fetch(for: VersionData.self) { error in
                    completion(nil, error, nil)
                }
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }

    func persist(with data: VersionData) {
        let model = VersionModel(data.versions)
        VersionModel().update(model)
    }

    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}

class ChampionGateway: Gateway {
    typealias Entity = Champion
    typealias EntityModel = ChampionModel
    typealias EntityData = ChampionData

    var version: String?
    var tasks: [Task<Void, Never>] = []

    init(version: String? = nil) {
        self.version = version
        self.tasks = []
    }

    func fetchData(completion: @escaping (ChampionData?, NetworkError?, DataError?) -> Void) {
        let networkHandler: APIFetchable = ChampionAPIFetcher(version: version)
        let task = Task {
            do {
                let data = try await networkHandler.fetch(for: ChampionData.self) { error in
                    completion(nil, error, nil)
                }
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }

    func fetchPersistedData(completion: @escaping (Bool) -> Void) {
        if let persistedData = ChampionModel().read() {
            completion(false)
        } else {
            fetchData { data, networkError, dataError in
                guard let data else { return }
                self.persist(with: data)
                completion(true)
            }
        }
    }

//    func fetchPersistedData(completion: @escaping (ChampionModel?, NetworkError?, DataError?) -> Void) {
//        if let persistedData = ChampionModel().read() {
//            completion(nil, nil, nil)
//        } else {
//            fetchData { data, networkError, dataError in
//                guard let data else { return }
//                self.persist(with: data)
//            }
//        }
//    }

    func persist(with data: ChampionData) {
        let model = ChampionModel(value: data)
        VersionModel().update(model)
    }

    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}

class ItemGateway: Gateway {
    typealias Entity = Item
    typealias EntityModel = ItemModel
    typealias EntityData = ItemData

    var version: String?
    var tasks: [Task<Void, Never>] = []

    init(version: String? = nil) {
        self.version = version
        self.tasks = []
    }

    func fetchData(completion: @escaping (ItemData?, NetworkError?, DataError?) -> Void) {
        let networkHandler: APIFetchable = ItemAPIFetcher(version: version)
        let task = Task {
            do {
                let data = try await networkHandler.fetch(for: ItemData.self) { error in
                    completion(nil, error, nil)
                }
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }

    func fetchPersistedData(completion: @escaping (Bool) -> Void) {
        if let persistedData = ItemModel().read() {
            completion(false)
        } else {
            fetchData { data, networkError, dataError in
                guard let data else { return }
                self.persist(with: data)
                completion(true)
            }
        }
    }

//    func fetchPersistedData(completion: @escaping (ItemModel?, NetworkError?, DataError?) -> Void) {
//        if let persistedData = ItemModel().read() {
//            completion(nil, nil, nil)
//        } else {
//            fetchData { data, networkError, dataError in
//                guard let data else { return }
//                self.persist(with: data)
//            }
//        }
//    }

    func persist(with data: ItemData) {
        let model = ItemModel(value: data)
        VersionModel().update(model)
    }

    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}

#warning("Dated implementation")
//final class Gateway {
//    private var tasks: [Task<Void, Never>] = []
//
//    func fetchVersions(completion: @escaping (VersionData?, NetworkError?, DataError?) -> Void) {
//        let networkHandler: APIFetchable = VersionAPIFetcher()
//        let task = Task {
//            do {
//                let version: String? = nil
//                let data = try await networkHandler.fetch(for: version, to: VersionData.self) { error in
//                    completion(nil, error, nil)
//                }
//                completion(data, nil, nil)
//            } catch {
//                completion(nil, nil, DataError.unreadable_Data)
//            }
//        }
//        tasks.append(task)
//    }
//
//    func fetchChampions(for version: String, completion: @escaping (ChampionData?, NetworkError?, DataError?) -> Void) {
//        let networkHandler: APIFetchable = ChampionAPIFetcher()
//        let task = Task {
//            do {
//                let data = try await networkHandler.fetch(for: version, to: ChampionData.self) { error in
//                    completion(nil, error, nil)
//                }
//                completion(data, nil, nil)
//            } catch {
//                completion(nil, nil, DataError.unreadable_Data)
//            }
//        }
//        tasks.append(task)
//    }
//
//    func fetchItems(for version: String, completion: @escaping (ItemData?, NetworkError?, DataError?) -> Void) {
//        let networkHandler: APIFetchable = ItemAPIFetcher()
//        let task = Task {
//            do {
//                let data = try await networkHandler.fetch(for: version, to: ItemData.self) { error in
//                    completion(nil, error, nil)
//                }
//                completion(data, nil, nil)
//            } catch {
//                completion(nil, nil, DataError.unreadable_Data)
//            }
//        }
//        tasks.append(task)
//    }
//
//    func cancelTasks() {
//        tasks.forEach({ $0.cancel() })
//        tasks = []
//    }
//}
