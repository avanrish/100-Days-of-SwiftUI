//
//  ExpenseViewModel.swift
//  iExpense
//
//  Created by Bartosz Lipiński on 17/04/2023.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    @Published var items: [Expense] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decoded = try? JSONDecoder().decode([Expense].self, from: savedItems) {
                items = decoded
                return
            }
        }
        items = []
    }
}
