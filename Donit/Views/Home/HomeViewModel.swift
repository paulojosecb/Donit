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
    
}
