//
//  AppCoordinator.swift
//  AppCoordinator
//
//  Created by Paulo José on 31/05/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit
import Coordinator
import HomeUI
import DetailUI

public class AppCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let vc = HomeViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    public func showDetail() {
        let vc = DetailViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
