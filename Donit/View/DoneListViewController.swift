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
        
        self.navigationController?.navigationBar.setTransparentBackground()
        
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
            doneListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            
        } catch _ as NSError {
            print("Deu ruim no fetch")
        }
    }
}

extension DoneListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return section == 0 ? 1 : doneList.count
        return doneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = doneList[indexPath.row].name
        return cell
    }
    
}

