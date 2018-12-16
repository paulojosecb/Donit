//
//  UIView.swift
//  RuleOfThumb
//
//  Created by Paulo José on 04/12/18.
//  Copyright © 2018 So Many Deadlines. All rights reserved.
//

import Foundation
import UIKit

enum FillMode {
    case opaque
    case gradient
}

extension UIView {
    
    func addRoundedBorder(in mode: FillMode, colors: [UIColor], radius: CGFloat = 10, shadowOppacity: CGFloat = 0.2, shadowRadius: CGFloat = 3) {
        
//        guard let layer = self.layer.sublayers?[0] as? CAShapeLayer else {
//            return
//        }
        
        if let layer = self.layer.sublayers?[0] as? CAShapeLayer {
            layer.removeFromSuperlayer()
        }
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.masksToBounds = false
        
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        
        switch mode {
        case .opaque:
            shadowLayer.fillColor = colors.first?.cgColor
        case .gradient:
            shadowLayer.fillColor = UIColor(patternImage: UIImage().imageWithGradient(startColor: colors[0], endColor: colors[1], size: self.bounds.size) ?? UIImage()).cgColor
        }
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
        
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func setBackgroundToGradient(with colors: [UIColor]) {
        
        let gradient = CAGradientLayer()
        
        gradient.colors = colors
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.bounds
        
        self.layer.insertSublayer(gradient, at: 0)
        
    }
    
}
