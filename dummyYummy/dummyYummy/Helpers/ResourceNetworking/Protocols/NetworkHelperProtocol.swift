//
//  NetworkHelperProtocol.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

/// Protocol for working with server
protocol NetworkHelperProtocol: AnyObject {
    /// Resource based data loading method
    ///
    /// - Parameters:
    ///   - resource: Resource
    ///   - completion: Result of the operation
    /// - Returns: Data load cancel object
    func load<T>(resource: Resource<T>, completion: @escaping (OperationCompletion<T>) -> Void) -> CancellationProtocol?
}
