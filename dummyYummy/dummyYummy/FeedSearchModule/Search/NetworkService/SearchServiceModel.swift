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
    let nutrition: SearchNutrition?
}

// MARK: - Nutrition
struct SearchNutrition: Codable {
    let nutrients: [SearchNutrient]
}

// MARK: - Nutrient
struct SearchNutrient: Codable {
    let title, name: String
    let amount: Double
    let unit: NutrienUnit
}

enum NutrienUnit: String, Codable {
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}
