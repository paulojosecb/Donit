//
//  LastWeekOverviewCardTableViewCell.swift
//  Donit
//
//  Created by Paulo José on 23/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class LastWeekOverviewCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var progressBarWrapperView: UIView!

    @IBOutlet var progressBars: [ProgressBarWithLabel]!
    @IBOutlet var progressBarLeadingConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var progressBarWrapperTopConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if progressBarWrapperView.frame.height > CGFloat(70.0) {
            progressBarWrapperTopConstraint.constant = 100
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        let newLeadingConstant = (progressBarWrapperView.frame.width - (progressBars[0].frame.width * CGFloat(progressBars.count))) / CGFloat(progressBars.count - 1)
        
        progressBarLeadingConstraints.forEach { (constrait) in
            constrait.constant = newLeadingConstant
        }
        
        cardView.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue])
        
        
        
    }
}
