//
//  OveriviewViewController.swift
//  Donit
//
//  Created by Paulo José on 20/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit
import CoreData

class OverviewViewController: UIViewController {
    
    var user: User!
    var managedContext: NSManagedObjectContext!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if managedContext == nil {
            guard let appDeledate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            managedContext = appDeledate.persistentContainer.viewContext
        }
        
        do {
            let users : [User] = try managedContext.fetch(User.fetchRequest())
            user = users[0]
            let username = user.name ?? ""
            self.navigationItem.title = "\(username),"
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    

}

extension OverviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            var cell = tableView.dequeueReusableCell(withIdentifier: "DoneListHeaderTableViewCell") as? DoneListHeaderTableViewCell
            if cell == nil {
                tableView.register(UINib(nibName: "DoneListHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DoneListHeaderTableViewCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "DoneListHeaderTableViewCell") as? DoneListHeaderTableViewCell
            }
            
            return cell ?? UITableViewCell()
        case 1:
            var cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyOverviewCardTableViewCell") as? WeeklyOverviewCardTableViewCell
            if cell == nil {
                tableView.register(UINib(nibName: "WeeklyOverviewCardTableViewCell", bundle: nil), forCellReuseIdentifier: "WeeklyOverviewCardTableViewCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyOverviewCardTableViewCell") as? WeeklyOverviewCardTableViewCell
            }
            
            return cell ?? UITableViewCell()
        
        case 2:
            var cell = tableView.dequeueReusableCell(withIdentifier: "LastWeekOverviewCardTableViewCell") as? LastWeekOverviewCardTableViewCell
            
            if cell == nil {
                tableView.register(UINib(nibName: "LastWeekOverviewCardTableViewCell", bundle: nil), forCellReuseIdentifier: "LastWeekOverviewCardTableViewCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "LastWeekOverviewCardTableViewCell") as? LastWeekOverviewCardTableViewCell
            }
            
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 75
        case 1:
            let scaleFactor: Double = 174/320
            let height = tableView.frame.width * CGFloat(scaleFactor)
            return height
        case 2:
            let scaleFactor: Double = 167/320
            let height = tableView.frame.width * CGFloat(scaleFactor)
            return height
        default:
            print("Error")
        }
        
        return 0
    }
    
}
