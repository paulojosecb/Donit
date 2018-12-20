//
//  OveriviewViewController.swift
//  Donit
//
//  Created by Paulo José on 20/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

}

extension OverviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 75
        case 1:
            let scaleFator : Double = 174/320
            let height = tableView.frame.width * CGFloat(scaleFator)
            return height
        default:
            print("Error")
        }
        
        return 0
    }
    
}
