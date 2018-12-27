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
    var currentDay: Day!
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
        
        self.navigationController?.navigationBar.barTintColor = UIColor.paleGrey
        self.navigationController?.navigationBar.shadowImage = UIImage()
        doneListTableView.backgroundColor = UIColor.paleGrey
        
        do {
            let users : [User] = try managedContext.fetch(User.fetchRequest())
            user = users[0]
            let username = user.name ?? ""
            self.navigationItem.title = "Hello, \(username)"
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        updateDataSource()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        print(getDayOfWeek("22/12/2018"))
    
    }

    @IBAction func addDidPress(_ sender: Any) {

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
        doneItem.day = currentDay
        
        currentDay.insertIntoDoneItems(doneItem, at: 0)
        
        do {
            try managedContext.save()
            updateDataSource()
            doneListTableView.insertRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
            doneListTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        } catch _ as NSError {
            print("Nao foi possivel salvar")
        }
        
    }
    
    func getDayOfWeek(_ today: String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd/MM-yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func updateDataSource() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if user == nil {
            
            do {
                let users : [User] = try managedContext.fetch(User.fetchRequest())
                user = users[0]
                let username = user.name ?? ""
                self.navigationItem.title = "Hello, \(username)"
            } catch let error as NSError {
                print(error.localizedDescription)
                fatalError()
            }
            
        }
        
        if user.weeks?.count == 0 {
            
            let currentWeek = Week(context: managedContext)
            
            let newDay = Day(context: managedContext)
            newDay.date = NSDate()
            
            currentWeek.addToDays(newDay)
            currentDay = newDay
            user.addToWeeks(currentWeek)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        } else {
            
            let currentWeek = user.weeks?.lastObject as? Week
            
            if let lastDayOnCurrentWeek = currentWeek?.days?.lastObject as? Day, let date = lastDayOnCurrentWeek.date as Date? {
               
                if dateFormatter.string(from: date) != dateFormatter.string(from: Date()) { //Se o dia de hoje for diferente do ultimo dia, cria um novo dia
                    
                    if getDayOfWeek(dateFormatter.string(from: date)) == 7 {
                        //Create new week
                        let newWeek = Week(context: managedContext)
                        user.addToWeeks(newWeek)
                        
                        let today = Day(context: managedContext)
                        today.date = NSDate()
                        newWeek.addToDays(today)
                        currentDay = today
                        
                    } else {
                        let newDay = Day(context: managedContext)
                        newDay.date = NSDate()
                        currentWeek?.addToDays(newDay)
                        currentDay = newDay
                    }
                    
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                    
                } else { //Se o dia atual for igual ao ultimo da lista, pega ele
                    currentDay = lastDayOnCurrentWeek
                }
                
            } else { //Se a semana estiver vazia, cria um novo dia
                
                let newDay = Day(context: managedContext)
                currentWeek?.addToDays(newDay)
                currentDay = newDay
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
            
        }
        
        guard let count = currentDay.doneItems?.count else { return }
        
        if count > 0 {
            doneListTableView.isHidden = false
            emptyStateCard.isHidden = true
        } else {
            doneListTableView.isHidden = true
            emptyStateCard.isHidden = false
        }
        
    }
}

extension DoneListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = currentDay.doneItems?.count ?? 0
        return section == 0 ? 1 : count + 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 && indexPath.row > 0 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let doneItems = currentDay.doneItems
            
            guard let itemToRemove : DoneItem = doneItems?.object(at: indexPath.row - 1) as? DoneItem else {return}
                        
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
        
        let cell = doneListTableView.cellForRow(at: indexPath)
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
        
            cell?.numberLabel.text = "\(currentDay.doneItems?.count ?? 0)"
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
            
            let reversedDoneItems = currentDay.doneItems?.reversed
            let item = reversedDoneItems?.object(at: indexPath.row - 1) as? DoneItem
            let name = item?.name
            cell?.nameLabel.text = item?.name
            
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 126 : indexPath.row == 0 ? 75 : 72
    }
        
}

extension DoneListViewController : AddScreenDelegate {
    
    func addItem(item: String) {
        self.saveDoneItem(with: item)
    }
    
}

