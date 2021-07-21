//
//  ResourceFactoryProtocol.swift
//  dummyYummy
//
//  Created by badyi on 21.07.2021.
//

import Foundation

protocol ResourceFactoryProtocol {
    func buildURL(_ baseURL: String, _ parameters: [String: Any]) -> URL?
    func createImageResource(_ url: String) -> Resource<Data>?
}

extension ResourceFactoryProtocol {
    func createImageResource(_ url: String) -> Resource<Data>? {
        guard let url = URL(string: url) else { return nil }

        let parse: (Data) throws -> Data = { data in
            return data
        }
        return Resource<Data>(url: url, method: .get, parse: parse)
    }

    func buildURL(_ baseURL: String, _ parameters: [String: Any]) -> URL? {
        guard let url = URL(string: baseURL) else { return nil }

        var com = URLComponents(url: url, resolvingAgainstBaseURL: false)
        com?.queryItems = [URLQueryItem]()

        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: "\(value)")
            com?.queryItems?.append(item)
        }

        return com?.url
    }
}
