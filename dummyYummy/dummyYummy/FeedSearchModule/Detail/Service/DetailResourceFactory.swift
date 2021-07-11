//
//  DetailResourceFactory.swift
//  dummyYummy
//
//  Created by badyi on 12.07.2021.
//

import Foundation

final class DetailResourceFactory {
    
}

extension DetailResourceFactory {
    
    // MARK: - Building url
    private func buildURL(_ baseURL: String,_ parameters: [String: Any]) -> URL? {
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
