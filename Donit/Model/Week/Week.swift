//
//  Week.swift
//  Donit
//
//  Created by Paulo José on 13/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
import CoreData

extension Week {
    
    static func createWeek() -> Week? {
        guard let weeks = CoreDataManager.shared.fetch(Week.fetchRequest()) else { return nil }
        let week = Week(context: CoreDataManager.shared.context)
        
        week.index = Int16(weeks.count)
        
        let dayOfTheWeek = Calendar.current.component(.weekday, from: Date())
        let firstDayOfTheWeek = Calendar.current.firstWeekday
        
        for i in firstDayOfTheWeek...dayOfTheWeek {
            let day = Day(context: CoreDataManager.shared.context)
            day.week = week
            day.date = Calendar.current.date(byAdding: .day, value: i - dayOfTheWeek, to: Date())
            day.index = Int16(i)
            week.addToDays(day)
        }
        
        for i in (dayOfTheWeek + 1)...7 {
            let day = Day(context: CoreDataManager.shared.context)
            day.week = week
            day.date = Calendar.current.date(byAdding: .day, value: i - dayOfTheWeek, to: Date())
            day.index = Int16(i)
            week.addToDays(day)
        }
        
       CoreDataManager.shared.saveContext()
       return week
    }
    
    func getWeekAverage() -> Int {
        guard let days = days else { return 0 }
        
        let sum = days.reduce(0, { accumulator, day in
            guard let day = day as? Day,
                let items = day.items,
                let accumulator = accumulator else { return 0 }
            return accumulator + items.count
        }) ?? 0
        
        return sum / days.count
    }
    
    static func getCurrentWeek() -> Week? {
        guard let weeks = CoreDataManager.shared.fetch(Week.fetchRequest()) else { return nil }
        
        if (weeks.count == 0) {
            let week = Week.createWeek()
            return week
        }
        
        let weekToReturn = weeks.filter { week -> Bool in
            return week.index == weeks.count - 1
        }.last
        
        guard let currentWeek = weekToReturn else { return nil }
        
        let isCurrentWeek = currentWeek.days?.reduce(false, { previous, day in
            
            guard let day = day as? Day,
                let date = day.date else { return false }
            
            return Calendar.current.isDateInToday(date) || previous!
        })
        
        if (isCurrentWeek!) {
            return currentWeek
        } else {
            let week = Week.createWeek()
            return week
        }
    }
    
    static func getCurrentDay() -> Day? {
        let currentWeek = Week.getCurrentWeek()
        
        guard let days = currentWeek?.days?.allObjects as? [Day] else { return nil }
        
        for day in days {
            
            guard let date = day.date else { return nil }
            
            if Calendar.current.isDateInToday(date) {
                return day
            }
        }
        
        return nil
    }
    
//    func getLastSevenWeeks() -> [Week]? {
//        guard let count = self.weeks?.count,
//            let weeks = self.weeks?.array as? [Week] else { return nil }
//
//        if (count < 7) {
//            return weeks
//        }
//
//        let lastSevenWeeks = Array(weeks.suffix(from: count - 7))
//
//        return lastSevenWeeks
//    }
    
//    func getLastSevenWeeksAverage() -> Int {
//        guard let lastSevenWeeks = self.getLastSevenWeeks() else { return 0 }
//
//        let sum = lastSevenWeeks.reduce(0, { accumulator, week in
//            return accumulator + week.getWeekAverage()
//        })
//
//        return sum / lastSevenWeeks.count
//    }
    
}
