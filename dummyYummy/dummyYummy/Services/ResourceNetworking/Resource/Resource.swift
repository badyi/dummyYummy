//
//  Resource.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

public struct Resource<ResourceType> {
    let url: URL // URL запроса
    let method: HttpMethod<Data> // Метод запроса
    let parse: (Data) throws -> ResourceType // Парсер ответа от сервара
    let headers: [String: String]? // Заголовки запроса

    public init(url: URL,
                method: HttpMethod<Data>,
                parse: @escaping (Data) throws -> ResourceType,
                headers: [String: String]? = nil) {

        self.url = url
        self.method = method
        self.parse = parse
        self.headers = headers
    }
}
