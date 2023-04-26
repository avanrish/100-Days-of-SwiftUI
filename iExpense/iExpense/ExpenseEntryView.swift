//
//  ExpenseEntryView.swift
//  iExpense
//
//  Created by Bartosz Lipiński on 17/04/2023.
//

import SwiftUI

struct ExpenseEntryView: View {
    let expense: Expense
    
    let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.type)
            }
            Spacer()
            Text(expense.amount, format: currencyFormat)
                .foregroundColor(expense.amount < 10 ? .green : expense.amount < 100 ? .blue : .red)
        }
        .accessibilityElement()
        .accessibilityLabel("\(expense.name) \(expense.amount)")
        .accessibilityHint(expense.type)
    }
}

struct ExpenseEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseEntryView(expense: Expense(name: "Test", type: "Personal", amount: 1))
    }
}
