//
//  Day+CoreDataProperties.swift
//  Donit
//
//  Created by Paulo José on 21/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: NSDate?
    @NSManaged public var week: Week?
    @NSManaged public var doneItems: NSOrderedSet?

}

// MARK: Generated accessors for doneItems
extension Day {

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
