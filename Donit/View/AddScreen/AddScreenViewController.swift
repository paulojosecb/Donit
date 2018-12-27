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
    var isPreseting: Bool = false

    @IBOutlet weak var cardViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backdropView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var doneItemTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var doneButtomBottomConstrait: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.isEnabled = false
        
        let username = UserDefaults.standard.value(forKey: "username") as? String ?? ""
        promptLabel.text = "What else have you done today, \(username)?"
        
        doneItemTextField.becomeFirstResponder()
        doneItemTextField.delegate = self
        
        backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backdropView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backdropViewDidPress)))
        
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
        
        doneItemTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cardView.addRoundedBorder(in: .opaque, colors: [UIColor.white])
        doneButton.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue], radius: 0, shadowOppacity: 0.5, shadowRadius: 10)
    }
    
    @objc func backdropViewDidPress() {
        doneItemTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text == "" {
            
            doneButton.isEnabled = false
            
        } else {
            
            doneButton.isEnabled = true
        }
        
    }

}

extension AddScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            doneItemTextField.resignFirstResponder()
            delegate.addItem(item: doneItemTextField.text ?? "")
            dismiss(animated: true, completion: nil)
            return true
        }
        
        return true
        
    }
    
}

extension AddScreenViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: .to)
        
        guard let toVC = toViewController else {
            return
        }
        
        isPreseting = !isPreseting
        
        if isPreseting {
            
            containerView.addSubview(toVC.view)
            backdropView.alpha = 0
            cardViewBottomConstraint.constant = cardView.frame.height + 10
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.backdropView.alpha = 1
                self.cardViewBottomConstraint.constant = 10
                self.view.layoutIfNeeded()
            }) { (completed) in
                transitionContext.completeTransition(completed)
            }
            
        } else {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.backdropView.alpha = 0
                self.cardViewBottomConstraint.constant = self.cardView.frame.height + 10
                self.view.layoutIfNeeded()
            }) { (completed) in
                transitionContext.completeTransition(true)
            }
            
        }
        
    }
    
    
    
}
