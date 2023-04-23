//
//  Activity.swift
//  Challenge 4
//
//  Created by Bartosz Lipiński on 20/04/2023.
//

import Foundation

struct Activity: Equatable, Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var noOfCompletion: Int
}
