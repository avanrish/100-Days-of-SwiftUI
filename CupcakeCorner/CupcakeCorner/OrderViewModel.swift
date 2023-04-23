//
//  OrderViewModel.swift
//  CupcakeCorner
//
//  Created by Bartosz Lipiński on 21/04/2023.
//

import Foundation

class OrderViewModel: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case orderData
    }

    struct OrderData: Codable {
        var type = 0
        var quantity = 3
        var extraFrosting = false
        var addSprinkles = false
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var orderData = OrderData()

    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                orderData.extraFrosting = false
                orderData.addSprinkles = false
            }
        }
    }

    var hasValidAddress: Bool {
        if orderData.name.trimmingCharacters(in: .whitespaces).isEmpty || orderData.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || orderData.city.trimmingCharacters(in: .whitespaces).isEmpty || orderData.zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }

    var cost: Double {
        var cost = Double(orderData.quantity) * 2
        cost += (Double(orderData.type) / 2)
        if orderData.extraFrosting {
            cost += Double(orderData.quantity)
        }
        if orderData.addSprinkles {
            cost += Double(orderData.quantity) / 2
        }
        return cost
    }

    init() {}

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(orderData, forKey: .orderData)
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        orderData = try container.decode(OrderData.self, forKey: .orderData)
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
    }
}
