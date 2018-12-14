//
//  ViewController.swift
//  Donit
//
//  Created by Paulo José on 14/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit
import CoreData

class DoneListViewController: UIViewController {
    
    var doneList : [DoneItem]!
    var managedContext : NSManagedObjectContext!

    @IBOutlet weak var doneListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        doneListTableView.delegate = self
        doneListTableView.dataSource = self
        
        self.navigationController?.navigationBar.setTransparentBackground()
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            let request : NSFetchRequest<DoneItem> = DoneItem.fetchRequest()
            
            print(dateFormatter.string(from: Date()))
            
            request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(DoneItem.createdOn), Date()])
            
            doneList = try managedContext.fetch(request)
            
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
    }

}

extension DoneListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : doneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

