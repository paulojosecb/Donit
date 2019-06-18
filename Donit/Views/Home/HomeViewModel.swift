//
//  HomeViewModel.swift
//  Donit
//
//  Created by Paulo José on 12/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate {
    func didUpdateFetchResults() -> [Item]?
}

class HomeViewModel {
    
    var delegate: HomeViewModelDelegate?
    
    func fetchItems() -> [Item]? {
        return CoreDataManager.shared.fetch(Item.fetchRequest())
    }
    
    func delete(item: Item) {
        CoreDataManager.shared.context.delete(item)
        CoreDataManager.shared.saveContext()
    }
    
    func getCurrentDayCount() -> Int {
        guard let currentDay = Week.getCurrentDay() else { return 0 }
        guard let count = Week.getCurrentDay()?.items?.count else { return 0 }
        return count
    }
    
}
