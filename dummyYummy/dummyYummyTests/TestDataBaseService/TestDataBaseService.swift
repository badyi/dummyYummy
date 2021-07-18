//
//  TestCoreDataService.swift
//  dummyYummyTests
//
//  Created by badyi on 17.07.2021.
//

import XCTest
import CoreData
@testable import dummyYummy

class TestDataBaseService: XCTestCase {
    var sut: DataBaseServiceProtocol!
    var stack: CoreDataStackProtocol!
    
    override func setUp() {
        super.setUp()
        stack = MockCoreDataStack.shared
        sut = DataBaseService(coreDataStack: stack)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAddByUpdateRecipes() {
        let recipe = RecipeDTO(id: 1, title: "hello sber")
        sut.update(recipes: [recipe])
        
        let storedRecipes = sut.allRecipes()
        
        XCTAssertEqual(storedRecipes.count, 1, "should be 1")
        XCTAssertEqual(storedRecipes[0].id, recipe.id)
        XCTAssertEqual(storedRecipes[0].title, recipe.title)
        
        clear()
    }
    
    func testUpdateExistingRecipes() {
        let recipe = RecipeDTO(id: 1, title: "hello school")
        let updRecipe = RecipeDTO(id: 1, title: "hello sber")
        sut.update(recipes: [recipe])
        
        sut.update(recipes: [updRecipe])
        
        let storedRecipes = sut.allRecipes()
        
        XCTAssertEqual(storedRecipes.count, 1, "should be 1")
        XCTAssertEqual(storedRecipes[0].id, recipe.id)
        XCTAssertEqual(storedRecipes[0].title, updRecipe.title)
        
        clear()
    }
    
    func testDelete() {
        let recipe1 = RecipeDTO(id: 1, title: "hello tests")
        let recipe2 = RecipeDTO(id: 2, title: "hello swift")
        let recipes = [recipe1, recipe2]
        
        sut.update(recipes: recipes)
        
        var storedRecipes = sut.allRecipes()
        
        XCTAssertEqual(storedRecipes.count, 2, "should be 2")
        
        sut.delete(recipes: recipes)
        
        storedRecipes = sut.allRecipes()
        
        XCTAssertEqual(storedRecipes.count, 0, "should be 0")
        
        clear()
    }
    
    func testDeleteAll() {
        let recipe1 = RecipeDTO(id: 1, title: "hello world")
        let recipe2 = RecipeDTO(id: 2, title: "hello swift")
        let recipes = [recipe1, recipe2]
        sut.update(recipes: recipes)
        
        var storedRecipes = sut.allRecipes()
        
        XCTAssertEqual(storedRecipes.count, 2, "should be 2")
        
        sut.deleteAll()
        storedRecipes = sut.allRecipes()
        
        XCTAssertEqual(storedRecipes.count, 0, "should be 0")
        
        clear()
    }
    
    func testGetAllRecipes() {
        let recipe1 = RecipeDTO(id: 1, title: "hello ios school")
        let recipe2 = RecipeDTO(id: 2, title: "hello tests")
        let recipes = [recipe1, recipe2]
        
        sut.update(recipes: recipes)
        let storedRecipes = sut.allRecipes()
        
        XCTAssertEqual(storedRecipes.count, 2, "should be 2")
        
        clear()
    }
    
    func testGetRecipeByPredicate() {
        let recipe1 = RecipeDTO(id: 1, title: "hello Xcode")
        let recipe2 = RecipeDTO(id: 2, title: "hello test")
        var recipes = [recipe1, recipe2]
        
        sut.update(recipes: recipes)
        
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: recipe1.id))
        recipes = sut.recipes(with: predicate)
        
        XCTAssertEqual(recipes.count, 1, "should be 1")
        XCTAssertEqual(recipes[0].id, recipe1.id)
        XCTAssertEqual(recipes[0].title, recipe1.title)
        
        clear()
    }
    
    func clear() {
        sut.deleteAll()
    }
}
