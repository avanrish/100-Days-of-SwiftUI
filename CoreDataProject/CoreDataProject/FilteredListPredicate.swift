//
//  FilteredListPredicate.swift
//  CoreDataProject
//
//  Created by Bartosz Lipiński on 22/04/2023.
//

import Foundation

enum FilteredListPredicate: String {
    case beginsWith = "BEGINSWITH"
    case beginsWithInsensitive = "BEGINSWITH[c]"
    case endsWith = "ENDSWITH"
    case endsWithInsensitive = "ENDSWITH[c]"
    case contains = "CONTAINS"
    case containsInsensitive = "CONTAINS[c]"
}
