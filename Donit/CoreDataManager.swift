//
//  CoreDataManager.swift
//  Donit
//
//  Created by Paulo José on 12/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
        
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Donit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T> (_ request: NSFetchRequest<T>) -> [T]! {
        return try? context.fetch(request)
    }
    
}
