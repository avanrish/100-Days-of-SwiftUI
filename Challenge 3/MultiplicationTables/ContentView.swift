//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Bartosz Lipiński on 15/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var upTo = 2
    @State private var amountOfQuestions = 5
    
    @State var isGameViewActive = false

    let possibleQuantities = [5, 10, 20]

    var body: some View {
        NavigationView {
            Form {
                Section("Multiplications table") {
                    Stepper("Up to: \(upTo)", value: $upTo, in: 2 ... 12)
                }
                Section("How many questions") {
                    Picker("Amount of questions", selection: $amountOfQuestions) {
                        ForEach(possibleQuantities, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                NavigationLink("Start", isActive: $isGameViewActive) {
                    GameView(amountOfQuestions: amountOfQuestions, upTo: upTo, isGameViewActive: $isGameViewActive)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
