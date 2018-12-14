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
    
    var user: User!
    var doneList : [DoneItem]!
    var managedContext : NSManagedObjectContext!


    @IBOutlet weak var doneListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        doneListTableView.delegate = self
        doneListTableView.dataSource = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor.paleGrey
        self.navigationController?.navigationBar.shadowImage = UIImage()
        doneListTableView.backgroundColor = UIColor.paleGrey
        
        do {
            
            user = try managedContext.fetch(User.fetchRequest()).first
            
            if user.name == nil {
                
                let alert = UIAlertController(title: "Qual seu nome", message: "Digite seu nome", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Write here your name"
                }
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.user.name = alert.textFields?.first?.text ?? "Joaquim"
                }))
                
                present(alert, animated: true) {
                    
                }
                
            }
            
            try managedContext.save()
            self.navigationController?.navigationBar.topItem?.title = "Hello, \(String(describing: user.name!))"
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            let request : NSFetchRequest<DoneItem> = DoneItem.fetchRequest()
            
//            request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(DoneItem.createdOn), Date()])
            
            doneList = try managedContext.fetch(request)
            
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    
    }

    @IBAction func addDidPress(_ sender: Any) {
        
        let alert = UIAlertController(title: "New DoneItem", message: "What've you done today?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Here"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.saveDoneItem(with: alert.textFields?.first?.text ?? "")
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveDoneItem(with name: String) {
        let doneItem = DoneItem(context: managedContext)
        doneItem.name = name
        doneItem.createdOn = NSDate()
        doneItem.createdBy = user
        
        user.addToDoneItems(doneItem)
        
        do {
            try managedContext.save()
            updateDataSource()
        } catch _ as NSError {
            print("Nao foi possivel salvar")
        }
    }
    
    func updateDataSource() {
        do {
            doneList = try managedContext.fetch(DoneItem.fetchRequest())
            doneListTableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            
        } catch _ as NSError {
            print("Deu ruim no fetch")
        }
    }
}

extension DoneListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : doneList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            var cell = doneListTableView.dequeueReusableCell(withIdentifier: "DailyOverviewCardTableViewCell") as? DailyOverviewCardTableViewCell
            
            if cell == nil {
                doneListTableView.register(UINib(nibName: "DailyOverviewCardTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyOverviewCardTableViewCell")
                cell = doneListTableView.dequeueReusableCell(withIdentifier: "DailyOverviewCardTableViewCell") as? DailyOverviewCardTableViewCell
            }
            
            return cell ?? UITableViewCell()
            
        case 1:
            
            if indexPath.row == 0 {
                
                var header = doneListTableView.dequeueReusableCell(withIdentifier: "DoneListHeaderTableViewCell") as? DoneListHeaderTableViewCell
                
                if header == nil {
                    doneListTableView.register(UINib(nibName: "DoneListHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DoneListHeaderTableViewCell")
                    header = doneListTableView.dequeueReusableCell(withIdentifier: "DoneListHeaderTableViewCell") as? DoneListHeaderTableViewCell
                }
                
                return header ?? UITableViewCell()
                
            }
            
            var cell = doneListTableView.dequeueReusableCell(withIdentifier: "DoneItemCardTableViewCell") as? DoneItemCardTableViewCell
            
            if cell == nil {
                doneListTableView.register(UINib(nibName: "DoneItemCardTableViewCell", bundle: nil), forCellReuseIdentifier: "DoneItemCardTableViewCell")
                cell = doneListTableView.dequeueReusableCell(withIdentifier: "DoneItemCardTableViewCell") as? DoneItemCardTableViewCell
            }
            
            cell?.nameLabel.text = doneList[indexPath.row - 1].name
            
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 126 : indexPath.row == 0 ? 92 : 72

    }
        
}

