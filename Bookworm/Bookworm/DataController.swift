//
//  DataController.swift
//  Bookworm
//
//  Created by Bartosz Lipiński on 22/04/2023.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
