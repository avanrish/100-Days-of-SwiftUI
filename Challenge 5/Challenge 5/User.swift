//
//  User.swift
//  Challenge 5
//
//  Created by Bartosz Lipiński on 23/04/2023.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
