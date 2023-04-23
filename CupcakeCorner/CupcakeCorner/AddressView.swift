//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Bartosz Lipiński on 21/04/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderViewModel: OrderViewModel

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderViewModel.orderData.name)
                TextField("Street Address", text: $orderViewModel.orderData.streetAddress)
                TextField("City", text: $orderViewModel.orderData.city)
                TextField("Zip", text: $orderViewModel.orderData.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(orderViewModel: orderViewModel)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!orderViewModel.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderViewModel: OrderViewModel())
    }
}
