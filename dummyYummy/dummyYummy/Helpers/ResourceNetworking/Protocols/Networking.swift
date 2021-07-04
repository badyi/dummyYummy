//
//  Networking.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

protocol Networking {
    func execute<A>(_ resource: Resource<A>, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellation?
}

// MARK: - Networking
extension URLSession: Networking {
    func execute<A>(_ resource: Resource<A>, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellation? {
        let request = URLRequest(resource: resource)
        let task = dataTask(with: request, completionHandler: completionHandler)
        task.resume()
        return task
    }
}
