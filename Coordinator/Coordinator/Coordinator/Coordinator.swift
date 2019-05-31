//
//  Coordinator.swift
//  Coordinator
//
//  Created by Paulo José on 31/05/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

public protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
    
    func start()
    func showDetail()

}
