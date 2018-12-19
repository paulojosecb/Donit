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

    @IBOutlet weak var floatButton: UIView!
    @IBOutlet weak var doneListTableView: UITableView!
    @IBOutlet weak var emptyStateCard: InfoCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if managedContext == nil {
            guard let appDeledate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            managedContext = appDeledate.persistentContainer.viewContext
        }
        
        emptyStateCard.isHidden = true
        doneListTableView.isHidden = false
        
        emptyStateCard.imageView.image = UIImage(named: "Empty")
        emptyStateCard.titleLabel.text = "Isn’t kind of empty here?"
        emptyStateCard.descriptionLabel.text = "Tap on this float button on the right corner and tell me what you’ve done today"
       
        doneListTableView.delegate = self
        doneListTableView.dataSource = self
        
        floatButton.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue], radius: floatButton.layer.frame.width/2, shadowOppacity: 0.5, shadowRadius: 10)
        
        floatButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addDidPress(_:))))
        
        let username = UserDefaults.standard.value(forKey: "username") as? String ?? "Stranger"
        
        self.navigationItem.title = "Hello, \(username)"
        self.navigationController?.navigationBar.barTintColor = UIColor.paleGrey
        self.navigationController?.navigationBar.shadowImage = UIImage()
        doneListTableView.backgroundColor = UIColor.paleGrey
        
        do {
            
            let users : [User] = try managedContext.fetch(User.fetchRequest())
            
            if users.count == 0 {
                
                let newUser = User(context: managedContext)
                
                let alert = UIAlertController(title: "Qual seu nome", message: "Digite seu nome", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Write here your name"
                }
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    newUser.name = alert.textFields?.first?.text ?? "Joaquim"
                    self.navigationController?.navigationBar.topItem?.title = "Hello, \(String(describing: newUser.name!))"
                }))
                
                present(alert, animated: true, completion: nil)
                
                user = newUser
                try managedContext.save()
        
            } else {
            
                user = users[0]
//                self.navigationController?.navigationBar.topItem?.title = "Hello, \(String(describing: users[0].name!))"
                
            }
            
            
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        updateDataSource()
    
    }

    @IBAction func addDidPress(_ sender: Any) {
        
//        let alert = UIAlertController(title: "New DoneItem", message: "What've you done today?", preferredStyle: .alert)
//
//        alert.addTextField { (textField) in
//            textField.placeholder = "Here"
//        }
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            self.saveDoneItem(with: alert.textFields?.first?.text ?? "")
//        }))
//
//        present(alert, animated: true, completion: nil)
        
        
        let vc = UIStoryboard(name: "AddScreen", bundle: nil).instantiateInitialViewController() as? AddScreenViewController
        vc?.modalPresentationStyle = .overCurrentContext
        vc?.delegate = self
        present(vc!, animated: true, completion: nil)
        
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
            doneListTableView.insertRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
            doneListTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        } catch _ as NSError {
            print("Nao foi possivel salvar")
        }
    }
    
    func updateDataSource() {
        do {
            let request : NSFetchRequest<DoneItem> = DoneItem.fetchRequest()
            let sort = NSSortDescriptor(key: #keyPath(DoneItem.createdOn), ascending: false)
            request.sortDescriptors = [sort]
            doneList = try managedContext.fetch(request)
            
            if doneList.count > 0 {
                doneListTableView.isHidden = false
                emptyStateCard.isHidden = true
            } else {
                doneListTableView.isHidden = true
                emptyStateCard.isHidden = false
            }
            
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 && indexPath.row > 0 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let itemToRemove = doneList[indexPath.row - 1] as? DoneItem else {return}
                        
            managedContext.delete(itemToRemove)
            
            do {
                try managedContext.save()
                updateDataSource()
                doneListTableView.deleteRows(at: [indexPath], with: .automatic)
                doneListTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            } catch _ as NSError {
                print("Problema ao deletar")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var cell = doneListTableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        
        print("HUEEE \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            var cell = doneListTableView.dequeueReusableCell(withIdentifier: "DailyOverviewCardTableViewCell") as? DailyOverviewCardTableViewCell
            
            if cell == nil {
                doneListTableView.register(UINib(nibName: "DailyOverviewCardTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyOverviewCardTableViewCell")
                cell = doneListTableView.dequeueReusableCell(withIdentifier: "DailyOverviewCardTableViewCell") as? DailyOverviewCardTableViewCell
            }
            
            cell?.numberLabel.text = "\(doneList.count)"
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

extension DoneListViewController : AddScreenDelegate {
    
    func addItem(item: String) {
        self.saveDoneItem(with: item)
    }
    
}

