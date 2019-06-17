//
//  AddViewController.swift
//  Donit
//
//  Created by Paulo José on 13/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    var navCoordinator: AppCoordinator?
    var viewModel: AddViewModel = AddViewModel()
    
    lazy var dismissGesture = UITapGestureRecognizer(target: self, action: #selector(onDismiss(_:)))
    lazy var addGesture = UITapGestureRecognizer(target: self, action: #selector(onAdd(_:)))
    
    lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var modalView: UIView = {
        let view = UIView()
        view.createSublayer(with: .white)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.text = "Cancel"
        label.textColor = .iris
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What else have you done today, Paulo?"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var input: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .iris
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var button: Button = {
        let button = Button()
        button.text = "Adicionar"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        modalView.createSublayer(with: .white)
        modalView.addRoundedBorder(with: 15.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(backdropView)
        view.addSubview(modalView)
        view.addSubview(cancelLabel)
        view.addSubview(titleLabel)
        view.addSubview(input)
        view.addSubview(line)
        view.addSubview(button)
        
        backdropView.addGestureRecognizer(dismissGesture)
//        cancelLabel.addGestureRecognizer(dismissGesture)
        button.addGestureRecognizer(addGesture)
        
        backdropView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backdropView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        modalView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: view.frame.height * 0.2).isActive = true
        modalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 100).isActive = true
        modalView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        cancelLabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 25.0).isActive = true
        cancelLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: cancelLabel.bottomAnchor, constant: 25.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        
        input.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 55).isActive = true
        input.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        input.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        
        line.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 2).isActive = true
        line.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        line.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        button.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: CGFloat(Button.height)).isActive = true
    }
    
    @objc func onDismiss(_ sender: UITapGestureRecognizer? = nil) {
        navCoordinator?.dismissModal()
    }
    
    @objc func onAdd(_ sender: UITapGestureRecognizer? = nil) {
        guard let itemToAdd = input.text else { return }
        viewModel.createItemWith(content: itemToAdd)
        navCoordinator?.dismissModal()
    }
}

