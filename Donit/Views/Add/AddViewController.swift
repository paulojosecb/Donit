//
//  AddViewController.swift
//  Donit
//
//  Created by Paulo José on 13/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.createSublayer(with: .white)
//        view.addRoundedBorder(with: 15.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(backdropView)
        view.addSubview(modalView)
        
        backdropView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backdropView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        modalView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        modalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 100).isActive = true
        modalView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

