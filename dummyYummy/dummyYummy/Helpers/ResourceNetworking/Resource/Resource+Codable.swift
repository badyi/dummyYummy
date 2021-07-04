//
//  Resource+Codable.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

extension Resource where ResourceType: Decodable {
    public init(url: URL, method: HttpMethod<Data> = .get, headers: [String : String]? = nil) {
        self.url = url
        self.method = method
        self.parse = { data in
            return try JSONDecoder().decode(ResourceType.self, from: data)
        }
        self.headers = headers
    }
}
