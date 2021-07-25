//
//  SearchServiceModel.swift
//  dummyYummy
//
//  Created by badyi on 29.06.2021.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let results: [SearchResult]
}

// MARK: - Result
struct SearchResult: Codable {
    let id: Int
    let title: String
    let image: String
}
