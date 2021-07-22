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
    let offset, number, totalResults: Int
}

// MARK: - Result
struct SearchResult: Codable {
    let id: Int
    let title: String
    let image: String
}
