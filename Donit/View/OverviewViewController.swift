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
    var coreDataManager: CoreDataManager!
    
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
            coreDataManager = CoreDataManager(managedContext: managedContext)
        }
        let user = coreDataManager.getUser()
        let username = user?.name ?? ""
        self.navigationItem.title = "\(username),"
        
    }
    

}

extension OverviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
            
            cell?.headerLabel.text = "This is your overview screen"
            return cell ?? UITableViewCell()
        case 1:
            var cell = tableView.dequeueReusableCell(withIdentifier: "DailyOverviewCardTableViewCell") as? DailyOverviewCardTableViewCell
            
            if cell == nil {
                tableView.register(UINib(nibName: "DailyOverviewCardTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyOverviewCardTableViewCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "DailyOverviewCardTableViewCell") as? DailyOverviewCardTableViewCell
            }
            
            let sum = coreDataManager.getLastSevenWeeksOverview()!
            cell?.numberLabel.text = "\(sum[sum.count - 2].count)"
            cell?.commentLabel.text = "is the number of things you’ve done in th last 7 days. Keep it up! 🎉🎉"
            return cell ?? UITableViewCell()
            
        case 2:
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCardTableViewCell") as? OverviewCardTableViewCell
            if cell == nil {
                tableView.register(UINib(nibName: "OverviewCardTableViewCell", bundle: nil), forCellReuseIdentifier: "OverviewCardTableViewCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCardTableViewCell") as? OverviewCardTableViewCell
            }
            
            cell?.mode = overviewMode.lastWeek
            cell?.dataSource = coreDataManager.getLastWeekOverView() ?? [OverviewModel]()
            return cell ?? UITableViewCell()
        
        case 3:
            var cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCardTableViewCell") as? OverviewCardTableViewCell
            
            if cell == nil {
                tableView.register(UINib(nibName: "OverviewCardTableViewCell", bundle: nil), forCellReuseIdentifier: "OverviewCardTableViewCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCardTableViewCell") as? OverviewCardTableViewCell
            }
            
            cell?.mode = overviewMode.sevenWeeks
            cell?.dataSource = coreDataManager.getLastSevenWeeksOverview()
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
            return 126
        case 2:
            let scaleFactor: Double = 190/320
            let height = tableView.frame.width * CGFloat(scaleFactor)
            return height
        case 3:
            let scaleFactor: Double = 190/320
            let height = tableView.frame.width * CGFloat(scaleFactor)
            return height
        default:
            print("Error")
        }
        
        return 0
    }
    
}
