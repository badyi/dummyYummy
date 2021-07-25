//
//  CoreData.swift
//  dummyYummy
//
//  Created by badyi on 13.07.2021.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    var moduleName: String { get }
    var entityName: String { get }

    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }

    /// Save context to persistant store
    func saveContext()
}

extension CoreDataStackProtocol {
    func saveContext() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                NSLog(error.localizedDescription)
            }
        }
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                NSLog(error.localizedDescription)
            }
        }
    }
}

class CoreDataStack: CoreDataStackProtocol {
    static let shared = CoreDataStack()

    let moduleName = "dummyYummy"
    let entityName = "MORecipe"
    /// for reading
    let mainContext: NSManagedObjectContext
    /// for writing
    let backgroundContext: NSManagedObjectContext

    private var managedObjectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "dummyYummy", withExtension: "momd") else {
            NSLog("MOMD url is nil")
            fatalError("CoreData MOMD is nil")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            NSLog("CoreData MOMD is nil")
            fatalError("CoreData MOMD is nil")
        }
        return model
    }()

    private var persistantStoreCoodrinator: NSPersistentStoreCoordinator

    private init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let url = URL(fileURLWithPath: documentsPath).appendingPathComponent("\(moduleName).sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        let storeType = NSSQLiteStoreType
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStore(ofType: storeType,
                                               configurationName: nil,
                                               at: url,
                                               options: options)
        } catch {
            fatalError("cant add perisistant store: \(error)")
        }

        persistantStoreCoodrinator = coordinator
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = persistantStoreCoodrinator

        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = mainContext
    }
}
