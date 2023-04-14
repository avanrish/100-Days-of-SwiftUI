//
//  ContentView.swift
//  BetterRest
//
//  Created by Bartosz Lipiński on 14/04/2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var bedTime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))

            return wakeUp - prediction.actualSleep
        } catch {
            return Date.now
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()

                } header: {
                    Text("When do you want to wake up?")
                }
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4 ... 12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                }
                Section {
                    Picker("Amount of cups", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) { n in
                            Text(n == 1 ? "1 cup" : "\(n) cups")
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                }
                Text("Your suggested bedtime: \(bedTime.formatted(.dateTime.hour().minute()))")
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
