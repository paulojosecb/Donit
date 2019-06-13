//
//  User.swift
//  Donit
//
//  Created by Paulo José on 13/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
import CoreData

extension User {

    static func createUser(with name: String) -> User {
        let user = User(context: CoreDataManager.shared.context)
        user.name = name
        user.addToWeeks(Week.createWeek())
        CoreDataManager.shared.saveContext()
        return user
    }
    
    func getCurrentWeek() -> Week? {
        guard let week = self.weeks?.lastObject as? Week else { return nil }
        
        let isCurrentWeek = week.days?.reduce(false, { previous, day in
            
            guard let day = day as? Day,
                  let date = day.date else { return false }
            
            return Calendar.current.isDateInToday(date) || previous!
        })
        
        if (isCurrentWeek!) {
            return week
        } else {
            self.addToWeeks(Week.createWeek())
            guard let week = self.weeks?.lastObject as? Week else { return nil }
            CoreDataManager.shared.saveContext()
            return week
        }
        
    }
    
//    func getLastSevenWeeks() -> [Weeks] {
//    }
}
