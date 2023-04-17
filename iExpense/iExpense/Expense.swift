//
//  Expense.swift
//  iExpense
//
//  Created by Bartosz Lipiński on 17/04/2023.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
