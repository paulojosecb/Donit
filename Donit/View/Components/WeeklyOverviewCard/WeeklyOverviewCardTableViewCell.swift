//
//  WeeklyOverviewCardTableViewCell.swift
//  Donit
//
//  Created by Paulo José on 20/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class WeeklyOverviewCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet var progressBars: [ProgressBar]!
    @IBOutlet weak var progressBarWrapperView: UIView!
    
    @IBOutlet var progressBarsLeadingContraints: [NSLayoutConstraint]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        cardView.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue])
        
        let newLeadingConstant = (progressBarWrapperView.frame.width - (progressBars[0].frame.width * CGFloat(progressBars.count))) / CGFloat(progressBars.count - 1)
        
        progressBarsLeadingContraints.forEach { (constrait) in
            constrait.constant = newLeadingConstant
        }

    }
    
}
