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
    
    func getCurrentDay() -> Day? {
        let currentWeek = self.getCurrentWeek()
        
        guard let days = currentWeek?.days?.array as? [Day] else { return nil }
        
        for day in days {
            
            guard let date = day.date else { return nil }
            
            if Calendar.current.isDateInToday(date) {
                return day
            }
        }
        
        return nil
    }
    
    func getLastSevenWeeks() -> [Week]? {
        guard let count = self.weeks?.count,
              let weeks = self.weeks?.array as? [Week] else { return nil }
        
        if (count < 7) {
            return weeks
        }
        
        let lastSevenWeeks = Array(weeks.suffix(from: count - 7))
        
        return lastSevenWeeks
    }
    
    func getLastSevenWeeksAverage() -> Int {
        guard let lastSevenWeeks = self.getLastSevenWeeks() else { return 0 }
        
        let sum = lastSevenWeeks.reduce(0, { accumulator, week in
            return accumulator + week.getWeekAverage()
        })
        
        return sum / lastSevenWeeks.count
    }
    
}
