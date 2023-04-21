//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Bartosz Lipiński on 21/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderViewModel = OrderViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderViewModel.orderData.type) {
                        ForEach(OrderViewModel.types.indices) {
                            Text(OrderViewModel.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(orderViewModel.orderData.quantity)", value: $orderViewModel.orderData.quantity, in: 3 ... 20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $orderViewModel.specialRequestEnabled.animation())
                    
                    if orderViewModel.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderViewModel.orderData.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $orderViewModel.orderData.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(orderViewModel: orderViewModel)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
