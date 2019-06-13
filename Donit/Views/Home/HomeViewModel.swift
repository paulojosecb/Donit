//
//  HomeViewModel.swift
//  Donit
//
//  Created by Paulo José on 12/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    func createItemWith(content: String) {
        let item = Item(context: CoreDataManager.shared.context)
        item.name = content
        item.day = Day(context: CoreDataManager.shared.context)
        CoreDataManager.shared.saveContext()
    }
    
    func fetchItems() -> [Item]? {
        return CoreDataManager.shared.fetch(Item.fetchRequest())
    }
    
}
