//
//  CustomizableView.swift
//  Donit
//
//  Created by Paulo José on 08/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

protocol CustomizableView {}

extension CustomizableView where Self: UIView {
    
    func createSublayer(with backgroundColor: UIColor) {
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        if let layer = self.layer.sublayers?[0] as? CAShapeLayer {
            layer.removeFromSuperlayer()
        }
        
        let newLayer = CAShapeLayer()
        newLayer.masksToBounds = false
        newLayer.path = UIBezierPath(rect: self.bounds).cgPath
        newLayer.fillColor = backgroundColor.cgColor
        
        self.layer.backgroundColor = .none
        self.layer.insertSublayer(newLayer, at: 0)
        
    }
    
    func createGradientSublayer(with backgroundColor: [UIColor]) {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        if let layer = self.layer.sublayers?[0] as? CAShapeLayer {
            layer.removeFromSuperlayer()
        }
        
        let newLayer = CAShapeLayer()
        newLayer.masksToBounds = false
        newLayer.path = UIBezierPath(rect: self.bounds).cgPath
        newLayer.fillColor = UIColor(patternImage: UIImage().imageWithGradient(startColor: backgroundColor[0], endColor: backgroundColor[1], size: self.bounds.size) ?? UIImage()).cgColor
        
        self.layer.backgroundColor = .none
        self.layer.insertSublayer(newLayer, at: 0)
    }
    
    func addRoundedBorder(with radius: CGFloat) {
        if let layer = self.layer.sublayers?[0] as? CAShapeLayer {
            layer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        }
    }
    
    func addShadow(color: UIColor, opacity: Float, offset: CGSize) {
        if let layer = self.layer.sublayers?[0] as? CAShapeLayer {
            layer.shadowColor = color.cgColor
            layer.shadowPath = layer.path
            layer.shadowOffset = offset
            layer.shadowOpacity = opacity
            
        }
    }
    
}

