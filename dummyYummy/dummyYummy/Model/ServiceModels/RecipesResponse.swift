import Foundation

struct RecipesResponse: Codable {
    let recipes: [RecipeInfoResponse]
}

struct RecipeInfoResponse: Codable {
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
    let instructions: String?
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
}

struct ExtendedIngredient: Codable {
    let id: Int?
    let original, originalString, originalName: String
}
