//
//  MockCoreDataStack.swift
//  dummyYummyTests
//
//  Created by badyi on 17.07.2021.
//

import Foundation
import CoreData
@testable import dummyYummy

class MockCoreDataStack: CoreDataStackProtocol {
    static let shared = MockCoreDataStack()
    
    let moduleName: String = "dummyYummy"
    
    var entityName: String = "MORecipe"
    
    var mainContext: NSManagedObjectContext
    
    var backgroundContext: NSManagedObjectContext
    
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    init() {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        persistentStoreCoordinator.addPersistentStore(with: description, completionHandler: { description,error in
            guard error == nil else {
                fatalError("fatal error")
            }
        })
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = mainContext
    }
}
