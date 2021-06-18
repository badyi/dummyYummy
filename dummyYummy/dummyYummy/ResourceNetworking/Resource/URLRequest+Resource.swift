//
//  URLRequest+Resource.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

extension URLRequest {
    // Создание запроса из Resource
    public init<A>(resource: Resource<A>){
        self.init(url: resource.url)
        httpMethod = resource.method.stringValue
        if case let .post(data) = resource.method {
            httpBody = data
        }
        allHTTPHeaderFields = resource.headers
    }
}
