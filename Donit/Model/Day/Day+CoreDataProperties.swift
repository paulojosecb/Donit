//
//  Day+CoreDataProperties.swift
//  Donit
//
//  Created by Paulo José on 17/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var date: Date?
    @NSManaged public var index: Int16
    @NSManaged public var items: NSSet?
    @NSManaged public var week: Week?

}

// MARK: Generated accessors for items
extension Day {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
