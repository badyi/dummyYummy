//
//  Resource.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

struct Resource<T> {
    let url: URL
    let method: HttpMethod<Data>
    let parse: (Data) throws -> T // Server response parser
    let headers: [String: String]?

    init(url: URL,
        method: HttpMethod<Data>,
        parse: @escaping (Data) throws -> T,
        headers: [String: String]? = nil) {

        self.url = url
        self.method = method
        self.parse = parse
        self.headers = headers
    }
}

extension Resource where T: Decodable {
    init(url: URL, method: HttpMethod<Data> = .get, headers: [String: String]? = nil) {
        self.url = url
        self.method = method
        self.parse = { data in
            return try JSONDecoder().decode(T.self, from: data)
        }
        self.headers = headers
    }
}
