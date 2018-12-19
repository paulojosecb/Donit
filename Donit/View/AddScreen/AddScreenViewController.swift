//
//  AddScreenViewController.swift
//  Donit
//
//  Created by Paulo José on 19/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class AddScreenViewController: UIViewController {
    
    var delegate : AddScreenDelegate!

    @IBOutlet weak var backdropView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var doneItemTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var doneButtomBottomConstrait: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = UserDefaults.standard.value(forKey: "username") as? String ?? ""
        promptLabel.text = "What else have you done today, \(username)?"
        
        doneItemTextField.becomeFirstResponder()
        doneItemTextField.delegate = self
        
        backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
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
        cardView.addRoundedBorder(in: .opaque, colors: [UIColor.white])
        doneButton.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue], radius: 0, shadowOppacity: 0.5, shadowRadius: 10)
    }
    
    @IBAction func cancelDidPress(_ sender: Any) {
        
        doneItemTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func AddDidPress(_ sender: Any) {
        doneItemTextField.resignFirstResponder()
        delegate.addItem(item: doneItemTextField.text ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.doneButtomBottomConstrait.constant = self.doneButtomBottomConstrait.constant - keyboardHeight
            }, completion: nil)
            
        }
    }
    
    @objc func keyboardWillDismiss(_ notification: Notification) {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.doneButtomBottomConstrait.constant = -8
        }, completion: nil)
        
    }

}

extension AddScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneItemTextField.resignFirstResponder()
        delegate.addItem(item: doneItemTextField.text ?? "")
        dismiss(animated: true, completion: nil)
        return true
    }
    
}
