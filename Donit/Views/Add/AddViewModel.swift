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
        item.day = Day(context: CoreDataManager.shared.context)
        CoreDataManager.shared.saveContext()
    }
}
