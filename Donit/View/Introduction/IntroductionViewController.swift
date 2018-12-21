//
//  IllustrationViewController.swift
//  Donit
//
//  Created by Paulo José on 18/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class IntroductionViewController: UIViewController {
    
    var managedContext : NSManagedObjectContext!

    @IBOutlet weak var startBottomConstrait: NSLayoutConstraint!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if managedContext == nil {
            guard let appDeledate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            managedContext = appDeledate.persistentContainer.viewContext
        }
        
        nameTextField.delegate = self
        
        self.navigationController?.navigationBar.setTransparentBackground()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDismiss(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         startButton.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue], radius: 0, shadowOppacity: 0.5, shadowRadius: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func startButtonDidPress(_ sender: Any) {
        nameTextField.resignFirstResponder()
        UserDefaults.standard.set(nameTextField.text, forKey: "username")
        
        let newUser = User(context: managedContext)
        newUser.name = nameTextField.text ?? ""
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        performSegue(withIdentifier: "showTutorial", sender: self)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.startBottomConstrait.constant = self.startBottomConstrait.constant - keyboardHeight
            }, completion: nil)
            
        }
    }
    
    @objc func keyboardWillDismiss(_ notification: Notification) {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.startBottomConstrait.constant = 0
        }, completion: nil)
        
    }
}

extension IntroductionViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        UserDefaults.standard.set(nameTextField.text, forKey: "username")
        
        let newUser = User(context: managedContext)
        newUser.name = nameTextField.text ?? ""
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        performSegue(withIdentifier: "showTutorial", sender: self)
        return true
    }
    
}

