//
//  ContentView.swift
//  Challenge 1
//
//  Created by Bartosz Lipiński on 12/04/2023.
//

import SwiftUI

enum DistanceUnits: String, CaseIterable {
    case m, km, feet, yards, miles
}

struct ContentView: View {
    @State private var inputDistance = 0.0
    @State private var inputUnit = "m"
    @State private var outputUnit = "m"
    
    @FocusState private var amountIsFocused: Bool
    
    var outputDistance: Double {
        var convertedInput: Double = 0
        // Convert all to m
        switch inputUnit {
        case DistanceUnits.km.rawValue:
            convertedInput = inputDistance * 1000
        case DistanceUnits.feet.rawValue:
            convertedInput = inputDistance / 3.281
        case DistanceUnits.yards.rawValue:
            convertedInput = inputDistance / 1.094
        case DistanceUnits.miles.rawValue:
            convertedInput = inputDistance * 1760
        default:
            convertedInput = inputDistance
        }
        
        switch outputUnit {
        case DistanceUnits.km.rawValue:
            return convertedInput / 1000
        case DistanceUnits.feet.rawValue:
            return convertedInput * 3.281
        case DistanceUnits.yards.rawValue:
            return convertedInput * 1.094
        case DistanceUnits.miles.rawValue:
            return convertedInput / 1609
        default:
            return convertedInput
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Distance", value: $inputDistance, format: .number)
                        .keyboardType(.decimalPad).focused($amountIsFocused)
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(DistanceUnits.allCases.map { $0.rawValue }, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input")
                }
                
                Section {
                    Text(outputDistance.formatted())
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(DistanceUnits.allCases.map { $0.rawValue }, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output")
                }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
