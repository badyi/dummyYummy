// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let randomRecipeResponse = try? newJSONDecoder().decode(RandomRecipeResponse.self, from: jsonData)

import Foundation

struct FeedRecipeResponse: Codable {
    let recipes: [FeedServiceRecipe]
}

struct FeedServiceRecipe: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let lowFodmap: Bool
    let aggregateLikes, spoonacularScore, healthScore: Int
    let pricePerServing: Double
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let image: String?
    let summary: String
    let cuisines: [String]
    let dishTypes: [String]
    let diets: [String]
    let occasions: [String]
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
    let spoonacularSourceURL: String?
    let preparationMinutes: Int?
    let cookingMinutes: Int?
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients, equipment: [Ent]
    let length: Length?
}

struct Ent: Codable {
    let id: Int
    let name, localizedName, image: String
    let temperature: Length?
}

struct Length: Codable {
    let number: Int
    let unit: LengthUnit
}

enum LengthUnit: String, Codable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case minutes = "minutes"
}

struct ExtendedIngredient: Codable {
    let id: Int?
    let aisle, image: String?
    let consistency: Consistency?
    let name: String
    let nameClean: String?
    let original, originalString, originalName: String
    let amount: Double
    let unit: String
    let meta, metaInformation: [String]
    let measures: Measures
}

enum Consistency: String, Codable {
    case liquid = "liquid"
    case solid = "solid"
}

struct Measures: Codable {
    let us, metric: Metric
}

struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}

