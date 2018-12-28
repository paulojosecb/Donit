//
//  ProgressBar.swift
//  Donit
//
//  Created by Paulo José on 20/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class ProgressBar: XibView {
    
    override var nibName: String {
        get {
            return "ProgressBar"
        }
    }
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    
    override func draw(_ rect: CGRect) {
        progressView.addRoundedBorder(in: .gradient, colors: [UIColor.pale, UIColor.lightSalmon], radius: 4, shadowOppacity: 0, shadowRadius: 0 )
    }
    

}
