//
//  NetworkServiceProtocol.swift
//  dummyYummy
//
//  Created by badyi on 21.07.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    var networkHelper: NetworkHelper { get }

    /// load function
    /// - Parameters:
    ///   - resource: Resource for network task
    ///   - completion: –°omplection handler with result of network task
    func load<T>( _ resource: Resource<T>,
                 completion: @escaping(OperationCompletion<T>) -> Void) -> CancellationProtocol?
}

extension NetworkServiceProtocol {
    func load<T>( _ resource: Resource<T>,
                 completion: @escaping(OperationCompletion<T>) -> Void) -> CancellationProtocol? {

        let cancel = networkHelper.load(resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return cancel
    }
}

enum ServiceError: Error {
    case resourceCreatingError
    case alreadyLoading
}
