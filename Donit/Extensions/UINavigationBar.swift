//
//  UINavigationBar.swift
//  RuleOfThumb
//
//  Created by Paulo José on 04/12/18.
//  Copyright © 2018 So Many Deadlines. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func setTransparentBackground() {
        //        self.setBackgroundImage(UIImage(), for: .default)
        self.isTranslucent = false
        self.shadowImage = UIImage()
        self.barTintColor = UIColor(patternImage:UIImage())
    }
    
    func setBarTintColorWithGradient(colors: [UIColor], size: CGSize) {
        let image = UIImage().imageWithGradient(startColor: colors[0], endColor: colors[1], size: size)
        self.barTintColor = UIColor(patternImage: image!)
        self.shadowImage = UIImage()
    }
    
}
