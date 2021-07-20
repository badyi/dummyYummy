//
//  SearchRefinements.swift
//  dummyYummy
//
//  Created by badyi on 24.06.2021.
//

import Foundation

enum Cuisine: String {
    case african = "African"
    case american = "American"
    case british = "British"
    case cajun = "Cajun"
    case caribbean = "Caribbean"
    case chinese = "Chinese"
    case easternEuropean = "Eastern European"
    case european = "European"
    case french = "French"
    case german = "German"
    case greek = "Greek"
    case indian = "Indian"
    case irish = "Irish"
    case italian = "Italian"
    case japanese = "Japanese"
    case jewish = "Jewish"
    case korean = "Korean"
    case latinAmerican = "Latin American"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case middleEastern = "Middle Eastern"
    case nordic = "Nordic"
    case southern = "Southern"
    case spanish = "Spanish"
    case thai = "Thai"
    case vietnamese = "Vietnamese"
}

enum Diet: String {
    case glutenFree = "Gluten Free"
    case ketogenic = "Ketogenic"
    case vegetarian = "Vegetarian"
    case lactoVegetarian = "Lacto-Vegetarian"
    case ovoVegetarian = "Ovo-Vegetarian"
    case vegan = "Vegan"
    case pescetarian = "pescetarian"
    case paleo = "Paleo"
    case primal = "Primal"
    case whole30 = "Whole30"
}

enum Intolerances: String {
    case dairy = "Dairy"
    case egg = "Egg"
    case gluten = "Gluten"
    case grain = "Grain"
    case peanut = "Peanut"
    case seafood = "Seafood"
    case sesame = "Sesame"
    case shellfish = "Shellfish"
    case soy = "Soy"
    case sulfite = "Sulfite"
    case treeNut = "Tree Nut"
    case wheat = "Wheat"
}

enum RefinementsSection {
    case time
    case cuisine
    case diet
    case intolearns
    // case ingredients
}

enum RefinementsRows {
    case time, cuisine, excludesCuisine, diet, intolearns
}

final class SearchRefinements {
    private var _maxReadyTime: Int?

    var maxReadyTime: Int? {
        get {
            _maxReadyTime
        }
        set {
            if newValue == 0 {
                _maxReadyTime = nil
                return
            }
            _maxReadyTime = newValue
        }
    }

    var cuisine: [Cuisine]?
    var excludedCuisine: [Cuisine]?

    var diet: Diet?
    var intolerances: [Intolerances]?
}
