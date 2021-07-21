//
//  IngredientsResponse.swift
//  dummyYummy
//
//  Created by badyi on 21.07.2021.
//

import Foundation

struct IngredientsResponseElement: Codable {
    let name: String
}

typealias IngredientsResponse = [IngredientsResponseElement]
