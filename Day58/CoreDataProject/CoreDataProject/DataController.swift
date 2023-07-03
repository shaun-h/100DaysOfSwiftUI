//
//  DataController.swift
//  Bookworm
//
//  Created by Shaun Hevey on 3/7/2023.
//

import CoreData
import Foundation


class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
}
