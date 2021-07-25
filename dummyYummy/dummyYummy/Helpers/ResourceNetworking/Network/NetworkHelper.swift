//
//  NetworkHelper.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

/// Manager for sending network requests, implements NetworkHelperProtocol
final class NetworkHelper {
    /// - noConnection: No network error
    enum NetworkErrors: Error {
        case noConnection
    }

    private let reachability: ReachabilityProtocol

    private let networking: Networking

    /// - Parameter reachability: An object to check if it is possible to send a request
    convenience init(reachability: ReachabilityProtocol) {
        self.init(reachability: reachability, networking: URLSession.shared)
    }

    /// - Parameters:
    ///   - reachability: An object to check if it is possible to send a request
    ///   - networking: Object sending requests to the network
    init(reachability: ReachabilityProtocol, networking: Networking) {
        self.reachability = reachability
        self.networking = networking
    }
}

// MARK: - NetworkHelperProtocol
extension NetworkHelper: NetworkHelperProtocol {
    func load<A>(resource: Resource<A>,
                        completion: @escaping (OperationCompletion<A>) -> Void) -> CancellationProtocol? {

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
