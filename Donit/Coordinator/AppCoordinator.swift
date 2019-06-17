//
//  AppCoordinator.swift
//  Donit
//
//  Created by Paulo José on 08/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
//        self.navigationController.navigationBar.setTransparentBackground()
    }
    
    func start() {
        let vc = HomeViewController()
        vc.navCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentModal() {
        let vc = AddViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .currentContext
        navigationController.pushViewController(vc, animated: true)
    }
}

