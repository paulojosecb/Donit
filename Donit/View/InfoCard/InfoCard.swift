//
//  InfoCard.swift
//  Donit
//
//  Created by Paulo José on 18/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class InfoCard: XibView {
    
    override var nibName: String {
        get {
            return "InfoCard"
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
