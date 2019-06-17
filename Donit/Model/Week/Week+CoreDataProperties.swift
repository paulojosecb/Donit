//
//  Week+CoreDataProperties.swift
//  Donit
//
//  Created by Paulo José on 17/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//
//

import Foundation
import CoreData


extension Week {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Week> {
        return NSFetchRequest<Week>(entityName: "Week")
    }

    @NSManaged public var index: Int16
    @NSManaged public var days: NSSet?

}

// MARK: Generated accessors for days
extension Week {

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: Day)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: Day)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSSet)

}
