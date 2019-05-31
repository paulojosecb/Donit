//
//  HomeViewController.swift
//  HomeUI
//
//  Created by Paulo José on 31/05/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit
import Coordinator

public class HomeViewController: UIViewController {
    
    var coordinator: Coordinator?
    
    convenience public init(coordinator: Coordinator) {
        self.init()
        self.coordinator = coordinator
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        guard let coordinator = coordinator else { return }
        
        coordinator.showDetail()
    }
}
