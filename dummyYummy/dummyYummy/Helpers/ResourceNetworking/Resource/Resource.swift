//
//  Resource.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

public struct Resource<T> {
    let url: URL // URL запроса
    let method: HttpMethod<Data> // Метод запроса
    let parse: (Data) throws -> T // Парсер ответа от сервара
    let headers: [String: String]? // Заголовки запроса

    public init(url: URL,
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
    public init(url: URL, method: HttpMethod<Data> = .get, headers: [String: String]? = nil) {
        self.url = url
        self.method = method
        self.parse = { data in
            return try JSONDecoder().decode(T.self, from: data)
        }
        self.headers = headers
    }
}
