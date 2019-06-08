//
//  HeaderView.swift
//  Donit
//
//  Created by Paulo José on 08/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    static let height: CGFloat = 58.0 + 20
    static let collumnSize: CGFloat = (UIScreen.main.bounds.width - 16 * 5) / 4
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.text = "Title"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
                
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:  16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:  -16).isActive = true
    }
    
}
