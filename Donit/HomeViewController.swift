//
//  HomeViewController.swift
//  Donit
//
//  Created by Paulo José on 08/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Olá, mundo"
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DoneItemCardCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DoneItemCardCell.height
    }
    
    
}
