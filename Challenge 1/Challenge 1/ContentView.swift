//
//  ContentView.swift
//  Challenge 1
//
//  Created by Bartosz Lipiński on 12/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var distanceManager: DistanceManager
    @FocusState private var amountIsFocused: Bool
    private var outputDistanceText: String {
        return distanceManager.outputDistance(inputDistance: distanceManager.inputDistance).formatted()
    }

    var body: some View {
        NavigationView {
            Form {
                inputSection
                outputSection
            }
            .navigationTitle("Unit converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    
    /// Component where user can enter distance to convert and its unit
    private var inputSection: some View {
        Section("Input") {
            TextField("Distance", value: $distanceManager.inputDistance, format: .number)
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
            Picker("Unit", selection: $distanceManager.inputUnit) {
                ForEach(DistanceUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    
    /// Component that shows converted distance and allows user to select its unit
    private var outputSection: some View {
        Section("Output") {
            Text(outputDistanceText)
            Picker("Unit", selection: $distanceManager.outputUnit) {
                ForEach(DistanceUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(distanceManager: DistanceManager())
    }
}
