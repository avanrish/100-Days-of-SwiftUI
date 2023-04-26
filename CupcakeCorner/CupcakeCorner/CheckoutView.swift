//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Bartosz Lipiński on 21/04/2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderViewModel: OrderViewModel

    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmationMessage = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)

                Text("Your total is \(orderViewModel.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingConfirmationMessage) {} message: {
            Text(confirmationMessage)
        }
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderViewModel) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(OrderViewModel.self, from: data)
            confirmationTitle = "Thank you!"
            confirmationMessage = "Your order for \(decodedOrder.orderData.quantity)x \(OrderViewModel.types[decodedOrder.orderData.type].lowercased()) cupcakes is on its way!"
        } catch {
            confirmationTitle = "Error"
            confirmationMessage = "Unfortunately we couldn't send your order due to lack of internet connection!"
        }
        showingConfirmationMessage = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderViewModel: OrderViewModel())
    }
}
