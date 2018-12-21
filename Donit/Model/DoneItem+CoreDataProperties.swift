//
//  DoneItem+CoreDataProperties.swift
//  Donit
//
//  Created by Paulo José on 21/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//
//

import Foundation
import CoreData


extension DoneItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoneItem> {
        return NSFetchRequest<DoneItem>(entityName: "DoneItem")
    }

    @NSManaged public var createdOn: NSDate?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var createdBy: User?
    @NSManaged public var day: Day?

}
