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

final class Gateway {
    private var tasks: [Task<Void, Never>] = []

    func fetchVersions(completion: @escaping (VersionData?, NetworkError?, DataError?) -> Void) {
        let networkHandler: APIFetchable = VersionAPIFetcher()
        let task = Task {
            do {
                let version: String? = nil
                let data = try await networkHandler.fetch(for: version, to: VersionData.self) { error in
                    completion(nil, error, nil)
                }
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }
    
    func fetchChampions(for version: String, completion: @escaping (ChampionData?, NetworkError?, DataError?) -> Void) {
        let networkHandler: APIFetchable = ChampionAPIFetcher()
        let task = Task {
            do {
                let data = try await networkHandler.fetch(for: version, to: ChampionData.self) { error in
                    completion(nil, error, nil)
                }
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }
    
    func fetchItems(for version: String, completion: @escaping (ItemData?, NetworkError?, DataError?) -> Void) {
        let networkHandler: APIFetchable = ItemAPIFetcher()
        let task = Task {
            do {
                let data = try await networkHandler.fetch(for: version, to: ItemData.self) { error in
                    completion(nil, error, nil)
                }
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}

//class Gateway {
//    var tasks: [Task<Void, Never>] = []
//
//    func cancelTasks() {
//        tasks.forEach({ $0.cancel() })
//        tasks = []
//    }
//}
//
//protocol Gatewayable {
//    var tasks: [Task<Void, Never>] { get set }
//    func cancelTasks()
//
//    func fetchData<T: Codable>(for version: String?, mappedTo modelType: T.Type, completion: @escaping (T.Type?, NetworkError?, DataError?) -> Void)
//}
//
//class VersionGateway: Gateway, Gatewayable {
//    func fetchData<T>(for version: String? = nil, mappedTo modelType: T.Type, completion: @escaping (T.Type?, NetworkError?, DataError?) -> Void) where T : Codable {
//        let networkHandler: APIFetchable = VersionAPIFetcher()
//        let task = Task {
//            do {
//                let version: String? = nil
//                let data = try await networkHandler.fetch(for: version, to: modelType.self) { error in
//                    completion(nil, error, nil)
//                }
//                completion(data as? T.Type, nil, nil)
//            } catch {
//                completion(nil, nil, DataError.unreadable_Data)
//            }
//        }
//        tasks.append(task)
//    }
//}
//
//class ChampionGateway: Gateway, Gatewayable {
//    func fetchData<T>(for version: String?, mappedTo modelType: T.Type, completion: @escaping (T.Type?, NetworkError?, DataError?) -> Void) where T : Codable {
//        let networkHandler: APIFetchable = ChampionAPIFetcher()
//        let task = Task {
//            do {
//                let data = try await networkHandler.fetch(for: version, to: modelType.self) { error in
//                    completion(nil, error, nil)
//                }
//                completion(data as? T.Type, nil, nil)
//            } catch {
//                completion(nil, nil, DataError.unreadable_Data)
//            }
//        }
//        tasks.append(task)
//    }
//}
//
//class ItemGateway: Gateway, Gatewayable {
//    func fetchData<T>(for version: String?, mappedTo modelType: T.Type, completion: @escaping (T.Type?, NetworkError?, DataError?) -> Void) where T : Codable {
//        let networkHandler: APIFetchable = ItemAPIFetcher()
//        let task = Task {
//            do {
//                let data = try await networkHandler.fetch(for: version, to: modelType.self) { error in
//                    completion(nil, error, nil)
//                }
//                completion(data as? T.Type, nil, nil)
//            } catch {
//                completion(nil, nil, DataError.unreadable_Data)
//            }
//        }
//        tasks.append(task)
//    }
//}
