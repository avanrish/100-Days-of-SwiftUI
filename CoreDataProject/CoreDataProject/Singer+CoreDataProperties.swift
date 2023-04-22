//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Bartosz Lipiński on 22/04/2023.
//
//

import CoreData
import Foundation

public extension Singer {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?

    internal var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    internal var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer: Identifiable {}
