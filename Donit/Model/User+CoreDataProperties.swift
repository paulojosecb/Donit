//
//  User+CoreDataProperties.swift
//  Donit
//
//  Created by Paulo José on 14/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var doneItems: DoneItem?

}
