//
//  NetworkHelper.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

/// Менеджер отправки сетевых запросов, реализует NetworkHelperProtocol
final class NetworkHelper {
    /// - noConnection: Ошибка отсутствия сети
    enum NetworkErrors: Error {
        case noConnection
    }

    private let reachability: ReachabilityProtocol

    private let networking: Networking

    /// - Parameter reachability: объект для проверки наличие возможности отправки запроса
    convenience init(reachability: ReachabilityProtocol) {
        self.init(reachability: reachability, networking: URLSession.shared)
    }

    /// - Parameters:
    ///   - reachability: объект для проверки наличие возможности отправки запроса
    ///   - networking: объект отсылающий запросы в сеть
    init(reachability: ReachabilityProtocol, networking: Networking) {
        self.reachability = reachability
        self.networking = networking
    }
}

// MARK: - NetworkHelperProtocol
extension NetworkHelper: NetworkHelperProtocol {
    func load<A>(resource: Resource<A>,
                        completion: @escaping (OperationCompletion<A>) -> Void) -> Cancellation? {

        if !reachability.isReachable {
            completion(.failure(NetworkErrors.noConnection))
            return nil
        }

        let task = networking.execute(resource) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                do {
                    let data = data ?? Data()
                    try completion(.success(resource.parse(data)))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        return task
    }
}
