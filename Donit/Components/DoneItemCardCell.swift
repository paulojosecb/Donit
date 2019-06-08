//
//  DoneItemCardCell.swift
//  Donit
//
//  Created by Paulo José on 08/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

extension UIView: CustomizableView {}

class DoneItemCardCell: UITableViewCell {
    
    static let height : CGFloat = 60
    static let collumnSize: CGFloat = (UIScreen.main.bounds.width - 16 * 5) / 4
    
    var item: String? {
        didSet {
            label.text = item
        }
    }
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Check")
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black70
        label.text = "Finished presentation"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        cardView.createSublayer(with: .white)
        cardView.addRoundedBorder(with: 10.0)
        cardView.addShadow(color: .black, opacity: 0.2, offset: CGSize(width: 0, height: 3))
    }
    
//    override func layoutSubviews() {
//        cardView.backgroundColor = .red
////        cardView.addRoundedBorder(with: 10.0)
////        cardView.addShadow(color: .black20, opacity: 0, offset: CGSize(width: 0, height: 3))
//    }
//
    func setupViews() {
        self.addSubview(cardView)
        self.addSubview(iconView)
        self.addSubview(label)
        
        cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cardView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        
        iconView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        iconView.centerXAnchor.constraint(equalTo: cardView.leftAnchor, constant: DoneItemCardCell.collumnSize / 2).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        
        label.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: DoneItemCardCell.collumnSize + 16.0).isActive = true
    }
    
}
