//
//  CoreDataManager.swift
//  Donit
//
//  Created by Paulo José on 27/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    let managedContext : NSManagedObjectContext
    
    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func getLastWeekOverView() -> [OverviewModel]! {
        
        var overview : [OverviewModel]!
        var user: User!
        
        do {
            user = try managedContext.fetch(User.fetchRequest()).last
            guard user != nil else { return nil }
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
        
        
        guard
            let weeks = user.weeks?.array as? [Week],
            weeks.count > 1,
            let lastWeek = weeks.last,
            let days = lastWeek.days?.array as? [Day],
            days.count == 7 else {
            return nil
        }
        
        overview = [OverviewModel]()
        
        for day in days {
            overview.append(OverviewModel(count: day.doneItems?.count ?? 0))
        }
        
        
        return overview
    }
    
    func getLastSevenWeeksOverview() -> [OverviewModel]! {
        
        var overview : [OverviewModel]!
        var user : User!
        
        do {
            user = try managedContext.fetch(User.fetchRequest()).last
            guard user != nil else { return nil }
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
        
        guard
            let weeks = user.weeks?.array as? [Week] else {
            return nil
        }
        
        let lastSevenWeeks = weeks.suffix(7)
    
        overview = [OverviewModel]()
        
        if lastSevenWeeks.count == 7 {
            
            for week in lastSevenWeeks {
                overview.append(OverviewModel(count: getCount(for: week)))
            }
            
        } else if lastSevenWeeks.count < 7 {
            
            for _ in 0..<(7 - lastSevenWeeks.count) {
                overview.append(OverviewModel(count: 0))
            }
            
            for week in lastSevenWeeks {
                overview.append(OverviewModel(count: getCount(for: week)))
            }
            
        }
        
        return overview
    }
    
    func getCount(for week: Week) -> Int {
        
        guard let days = week.days?.array as? [Day] else { return 0 }
        
        let sum = days.reduce(0, { previous, d in
            let day = d as Day
            return previous + (day.doneItems?.count ?? 0)
        })
        
        return sum
        
    }
}
