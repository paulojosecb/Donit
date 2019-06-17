//
//  AddViewModel.swift
//  Donit
//
//  Created by Paulo José on 13/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class AddViewModel {
    
    func createItemWith(content: String) {
        let item = Item(context: CoreDataManager.shared.context)
        item.name = content
        
        let currentDay = Week.getCurrentDay()
        currentDay?.addToItems(item)
        
        item.day = currentDay
        CoreDataManager.shared.saveContext()
    }
}
