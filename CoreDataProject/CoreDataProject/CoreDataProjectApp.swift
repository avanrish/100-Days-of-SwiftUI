//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Bartosz Lipiński on 22/04/2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
