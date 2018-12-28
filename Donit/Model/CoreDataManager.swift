//
//  CoreDataManager.swift
//  Donit
//
//  Created by Paulo José on 27/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    let managedContext : NSManagedObjectContext
    
    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func getLastWeekSum() -> Int {
        let user = getUser()
        let weeks = user?.weeks?.array as? [Week]
        let count = weeks?.count ?? 0
        
        if count > 1 {
            let lastWeek = weeks?[count - 2]
            let days = lastWeek?.days?.array as? [Day]
            
            let sum = days?.reduce(0, { previous, d in
                let day = d as Day
                let count = day.doneItems?.count ?? 0
                return previous ?? 0 + count
            })
            
            return sum ?? 0
        }
        
        return 0
        
    }

    func getLastWeekOverView() -> [OverviewModel]! {
        
        var overview : [OverviewModel]!
        _ = getUser()
    
        guard
            let currentWeek = getCurrentWeek(),
            let days = currentWeek.days?.array as? [Day] else {
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
        let user = getUser()
        
        guard
            let weeks = user?.weeks?.array as? [Week] else {
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
    
    func getDayOfWeek(_ today: String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd/MM-yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func createUser(with name: String) {
        let newUser = User(context: managedContext)
        newUser.name = name
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        createNewWeek()
    }
    
    func createNewWeek() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let newWeek = Week(context: managedContext)
        let user = getUser()
        
        guard user != nil else { return }
        
        let dayOfTheWeek = getDayOfWeek(dateFormatter.string(from: Date()))
        
        for i in 1...7 {
            let date = Calendar.current.date(byAdding: .day, value: i - dayOfTheWeek!, to: Date())
            let newDay = Day(context: managedContext)
            newDay.date = date as NSDate?
            newWeek.addToDays(newDay)
        }
        
        user?.addToWeeks(newWeek)
    
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }

    }
    
    func getCurrentDay() -> Day! {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard getUser() != nil else { return nil }
        
        let currentWeek = getCurrentWeek()
        let days = currentWeek?.days?.array as! [Day]
        
        let currentDay = days.first { (day) -> Bool in
            let isEqual = dateFormatter.string(from: day.date! as Date) == dateFormatter.string(from: Date())
            return isEqual
        }
        
        if currentDay == nil {
            createNewWeek()
            return getCurrentDay()
        }
        
        return currentDay
    }
    
    func getUser() -> User! {
        var user: User!
        do {
            let users: [User] = try managedContext.fetch(User.fetchRequest())
            user = users[0]
            guard user != nil else { return nil }
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
        
        return user
    }
    
    func getCurrentWeek() -> Week! {
        
        guard let user = getUser() else { return nil }
        
        var currentWeek = user.weeks?.lastObject as? Week
        
        if currentWeek == nil {
            createNewWeek()
            currentWeek = user.weeks?.lastObject as? Week
        }
        
        return currentWeek
        
    }
}
