//
//  OverviewCard.swift
//  Donit
//
//  Created by Paulo José on 08/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

extension UIView: CustomizableView {}

class OverviewCardCell: UITableViewCell {
    
    static let height: CGFloat = UIScreen.main.bounds.height * 0.20
    static let collumnSize: CGFloat = (UIScreen.main.bounds.width - 16 * 5) / 4

    var number: Int = 5 {
        didSet {
            numberLabel.text = "\(number)"
        }
    }
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48.0, weight: .medium)
        label.text = "5"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        label.text = "is the number of things you’ve done so far. Keep it up! 🎉🎉"
        return label
    }()
    
    override func layoutSubviews() {
        cardView.createSublayer(with: [.lightishBlue, .greenyBlue])
        cardView.addRoundedBorder(with: 10.0)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(cardView)
        self.addSubview(numberLabel)
        self.addSubview(descriptionLabel)
        
        cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cardView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        
        numberLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        numberLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 24.0).isActive = true
        
        descriptionLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: OverviewCardCell.collumnSize + 16.0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16.0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -16.0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16.0).isActive = true
    }

    
}
