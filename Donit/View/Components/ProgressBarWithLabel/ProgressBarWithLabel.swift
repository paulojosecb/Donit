//
//  ProgressBarWithLabel.swift
//  Donit
//
//  Created by Paulo José on 23/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class ProgressBarWithLabel: XibView {

    override var nibName: String {
        get {
            return "ProgressBarWithLabel"
        }
    }
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    
    override func draw(_ rect: CGRect) {
        progressView.addRoundedBorder(in: .gradient, colors: [UIColor.pale, UIColor.lightSalmon], radius: 4, shadowOppacity: 0, shadowRadius: 0 )
    }

}
