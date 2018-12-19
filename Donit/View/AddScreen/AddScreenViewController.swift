//
//  AddScreenViewController.swift
//  Donit
//
//  Created by Paulo José on 19/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class AddScreenViewController: UIViewController {

    @IBOutlet weak var backdropView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var doneItemTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        contentView.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        cardView.addRoundedBorder(in: .opaque, colors: [UIColor.white])
        backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        doneButton.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue], radius: 0, shadowOppacity: 0.5, shadowRadius: 10)
    }
    
    @IBAction func cancelDidPress(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
