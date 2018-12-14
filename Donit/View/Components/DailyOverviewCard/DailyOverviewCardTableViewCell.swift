//
//  DailyOverviewCardTableViewCell.swift
//  Donit
//
//  Created by Paulo José on 14/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class DailyOverviewCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue])
//        cardView.setBackgroundToGradient(with: [UIColor.lightishBlue, UIColor.greenyBlue])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
