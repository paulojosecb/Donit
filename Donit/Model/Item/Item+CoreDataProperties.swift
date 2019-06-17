//
//  Item+CoreDataProperties.swift
//  Donit
//
//  Created by Paulo José on 17/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var day: Day?

}
