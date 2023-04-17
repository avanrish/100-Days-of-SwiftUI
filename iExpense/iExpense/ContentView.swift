//
//  ContentView.swift
//  iExpense
//
//  Created by Bartosz Lipiński on 17/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenseViewModel = ExpenseViewModel()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            VStack {
                Section("Personal") {
                    List {
                        ForEach(expenseViewModel.items.filter { item in item.type == "Personal" }) { item in
                            ExpenseEntryView(expense: item)
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                Section("Business") {
                    List {
                        ForEach(expenseViewModel.items.filter { item in item.type == "Business" }) { item in
                            ExpenseEntryView(expense: item)
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenseViewModel: expenseViewModel)
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenseViewModel.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
