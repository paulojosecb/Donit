//
//  Week+CoreDataProperties.swift
//  Donit
//
//  Created by Paulo José on 21/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//
//

import Foundation
import CoreData


extension Week {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Week> {
        return NSFetchRequest<Week>(entityName: "Week")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var doneItems: NSOrderedSet?

}

// MARK: Generated accessors for doneItems
extension Week {

    @objc(insertObject:inDoneItemsAtIndex:)
    @NSManaged public func insertIntoDoneItems(_ value: Week, at idx: Int)

    @objc(removeObjectFromDoneItemsAtIndex:)
    @NSManaged public func removeFromDoneItems(at idx: Int)

    @objc(insertDoneItems:atIndexes:)
    @NSManaged public func insertIntoDoneItems(_ values: [Week], at indexes: NSIndexSet)

    @objc(removeDoneItemsAtIndexes:)
    @NSManaged public func removeFromDoneItems(at indexes: NSIndexSet)

    @objc(replaceObjectInDoneItemsAtIndex:withObject:)
    @NSManaged public func replaceDoneItems(at idx: Int, with value: Week)

    @objc(replaceDoneItemsAtIndexes:withDoneItems:)
    @NSManaged public func replaceDoneItems(at indexes: NSIndexSet, with values: [Week])

    @objc(addDoneItemsObject:)
    @NSManaged public func addToDoneItems(_ value: Week)

    @objc(removeDoneItemsObject:)
    @NSManaged public func removeFromDoneItems(_ value: Week)

    @objc(addDoneItems:)
    @NSManaged public func addToDoneItems(_ values: NSOrderedSet)

    @objc(removeDoneItems:)
    @NSManaged public func removeFromDoneItems(_ values: NSOrderedSet)

}
