//
//  TutorialCard.swift
//  Donit
//
//  Created by Paulo José on 18/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class TutorialCard: XibView {

    override var nibName: String {
        get {
            return "TutorialCard"
        }
    }
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
}
