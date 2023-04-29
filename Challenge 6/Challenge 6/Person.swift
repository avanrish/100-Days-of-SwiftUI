//
//  Person.swift
//  Challenge 6
//
//  Created by Bartosz Lipiński on 29/04/2023.
//

import Foundation

struct Person: Identifiable, Comparable {
    let id: UUID
    let name: String
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
}
