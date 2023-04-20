//
//  ActivityViewModel.swift
//  Challenge 4
//
//  Created by Bartosz Lipiński on 20/04/2023.
//

import Foundation

class ActivityViewModel: ObservableObject {
    @Published var isAddActivitySheetPresented = false
    @Published var activities: [Activity] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }

    init(isAddActivitySheetPresented: Bool) {
        self.isAddActivitySheetPresented = isAddActivitySheetPresented
        if let savedItems = UserDefaults.standard.data(forKey: "activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                activities = decoded
                return
            }
        }
        activities = []
    }

    func addActivityCompletion(activity: Activity) {
        if let index = activities.firstIndex(of: activity) {
            activities[index].noOfCompletion += 1
        }
    }
}
