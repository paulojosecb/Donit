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
    
    static func createWeek() -> Week {
        let week = Week(context: CoreDataManager.shared.context)
        
        let dayOfTheWeek = Calendar.current.component(.weekday, from: Date())
        let firstDayOfTheWeek = Calendar.current.firstWeekday
        
        for i in firstDayOfTheWeek...dayOfTheWeek {
            let day = Day(context: CoreDataManager.shared.context)
            day.week = week
            day.date = Calendar.current.date(byAdding: .day, value: i - dayOfTheWeek, to: Date())
            week.addToDays(day)
        }
        
        for i in (dayOfTheWeek + 1)...7 {
            let day = Day(context: CoreDataManager.shared.context)
            day.week = week
            day.date = Calendar.current.date(byAdding: .day, value: i - dayOfTheWeek, to: Date())
            week.addToDays(day)
        }
        
//       CoreDataManager.shared.saveContext()
        return week
    }
    
}
