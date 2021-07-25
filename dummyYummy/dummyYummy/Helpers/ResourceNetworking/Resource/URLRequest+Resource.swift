//
//  URLRequest+Resource.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

extension URLRequest {
    /// Making a request from a Resource
    /// - Parameter resource: Resource
    init<T>(resource: Resource<T>) {
        self.init(url: resource.url)
        httpMethod = resource.method.stringValue
        if case let .post(data) = resource.method {
            httpBody = data
        }
        allHTTPHeaderFields = resource.headers
    }
}
