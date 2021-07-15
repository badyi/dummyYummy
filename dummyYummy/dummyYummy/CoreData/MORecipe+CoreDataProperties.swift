//
//  MORecipe+CoreDataProperties.swift
//  dummyYummy
//
//  Created by badyi on 13.07.2021.
//
//

import Foundation
import CoreData


extension MORecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MORecipe> {
        return NSFetchRequest<MORecipe>(entityName: "MORecipe")
    }

    @NSManaged public var spoonacularSourceURL: String?
    @NSManaged public var sourceURL: String?
    @NSManaged public var instructions: Array<String>?
    @NSManaged public var ingredients: Array<String>?
    @NSManaged public var diets: Array<String>?
    @NSManaged public var dishTypes: Array<String>?
    @NSManaged public var cuisines: Array<String>?
    @NSManaged public var servings: Int64
    @NSManaged public var readyInMinutes: Int64
    @NSManaged public var pricePerServing: Double
    @NSManaged public var healthScore: Int64
    @NSManaged public var boolCharacteristics: Dictionary<String, Bool>?
    @NSManaged public var imageURL: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int64
    @NSManaged public var imagePath: URL?

}

extension MORecipe : Identifiable {

}
