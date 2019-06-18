//
//  HomeViewController.swift
//  Donit
//
//  Created by Paulo José on 08/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel = HomeViewModel()
    var navCoordinator: AppCoordinator?
    
    var overviewCell: OverviewCardCell?
    
    var dataSource: [Item]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Olá, mundo"
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var fetchRequest: NSFetchRequest<Item> = {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        let sort = NSSortDescriptor(key: #keyPath(Item.name), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        return fetchRequest
    }()
    
    lazy var fetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: CoreDataManager.shared.context, sectionNameKeyPath: nil, cacheName: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hello, Stranger"
        
        do {
            fetchedResultsController.delegate = self
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
                
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        let button = Button()
        button.text = "Adicionar"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addGestureRecognizer(tap)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        navCoordinator?.presentModal()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            guard let sectionInfo = fetchedResultsController.sections?[0] else { return 0 }
            return sectionInfo.numberOfObjects
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = OverviewCardCell()
            self.overviewCell = cell
            cell.number = viewModel.getCurrentDayCount()
            return cell
        } else {
            let cell = DoneItemCardCell()
            let index = IndexPath(row: indexPath.row, section: 0)
            cell.item = fetchedResultsController.object(at: index).name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? OverviewCardCell.height : DoneItemCardCell.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 1) {
            let view = HeaderView()
            view.title = "These are the things you’ve done today"
            return view
        }
                
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : HeaderView.height
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1 ? true : false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = IndexPath(row: indexPath.row, section: 0)
            viewModel.delete(item: fetchedResultsController.object(at: index))
        }
    }
    
}

extension HomeViewController: NSFetchedResultsControllerDelegate {

    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            let index = IndexPath(row: newIndexPath.row, section: 1)
            tableView.insertRows(at: [index], with: .automatic)
        case .delete:
            guard let newIndexPath = newIndexPath else { return }
            let index = IndexPath(row: newIndexPath.row, section: 1)
            tableView.deleteRows(at: [index], with: .automatic)
        default:
            print("Action not implemented")
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        guard let cell = self.overviewCell else { return }
        cell.number = viewModel.getCurrentDayCount()
    }
    
}
