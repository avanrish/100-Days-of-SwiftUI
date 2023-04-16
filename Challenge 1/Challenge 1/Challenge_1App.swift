//
//  Challenge_1App.swift
//  Challenge 1
//
//  Created by Bartosz Lipiński on 12/04/2023.
//

import SwiftUI

@main
struct Challenge_1App: App {
    let distanceManager = DistanceManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(distanceManager: distanceManager)
        }
    }
}
