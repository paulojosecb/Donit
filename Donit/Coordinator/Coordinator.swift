//
//  Coordinator.swift
//  Donit
//
//  Created by Paulo José on 08/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    func start()
}
