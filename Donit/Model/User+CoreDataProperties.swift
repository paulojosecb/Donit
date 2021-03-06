//
//  User+CoreDataProperties.swift
//  Donit
//
//  Created by Paulo José on 21/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var doneItems: NSOrderedSet?
    @NSManaged public var weeks: NSOrderedSet?

}

// MARK: Generated accessors for doneItems
extension User {

    @objc(insertObject:inDoneItemsAtIndex:)
    @NSManaged public func insertIntoDoneItems(_ value: DoneItem, at idx: Int)

    @objc(removeObjectFromDoneItemsAtIndex:)
    @NSManaged public func removeFromDoneItems(at idx: Int)

    @objc(insertDoneItems:atIndexes:)
    @NSManaged public func insertIntoDoneItems(_ values: [DoneItem], at indexes: NSIndexSet)

    @objc(removeDoneItemsAtIndexes:)
    @NSManaged public func removeFromDoneItems(at indexes: NSIndexSet)

    @objc(replaceObjectInDoneItemsAtIndex:withObject:)
    @NSManaged public func replaceDoneItems(at idx: Int, with value: DoneItem)

    @objc(replaceDoneItemsAtIndexes:withDoneItems:)
    @NSManaged public func replaceDoneItems(at indexes: NSIndexSet, with values: [DoneItem])

    @objc(addDoneItemsObject:)
    @NSManaged public func addToDoneItems(_ value: DoneItem)

    @objc(removeDoneItemsObject:)
    @NSManaged public func removeFromDoneItems(_ value: DoneItem)

    @objc(addDoneItems:)
    @NSManaged public func addToDoneItems(_ values: NSOrderedSet)

    @objc(removeDoneItems:)
    @NSManaged public func removeFromDoneItems(_ values: NSOrderedSet)

}

// MARK: Generated accessors for weeks
extension User {

    @objc(insertObject:inWeeksAtIndex:)
    @NSManaged public func insertIntoWeeks(_ value: Week, at idx: Int)

    @objc(removeObjectFromWeeksAtIndex:)
    @NSManaged public func removeFromWeeks(at idx: Int)

    @objc(insertWeeks:atIndexes:)
    @NSManaged public func insertIntoWeeks(_ values: [Week], at indexes: NSIndexSet)

    @objc(removeWeeksAtIndexes:)
    @NSManaged public func removeFromWeeks(at indexes: NSIndexSet)

    @objc(replaceObjectInWeeksAtIndex:withObject:)
    @NSManaged public func replaceWeeks(at idx: Int, with value: Week)

    @objc(replaceWeeksAtIndexes:withWeeks:)
    @NSManaged public func replaceWeeks(at indexes: NSIndexSet, with values: [Week])

    @objc(addWeeksObject:)
    @NSManaged public func addToWeeks(_ value: Week)

    @objc(removeWeeksObject:)
    @NSManaged public func removeFromWeeks(_ value: Week)

    @objc(addWeeks:)
    @NSManaged public func addToWeeks(_ values: NSOrderedSet)

    @objc(removeWeeks:)
    @NSManaged public func removeFromWeeks(_ values: NSOrderedSet)

}
