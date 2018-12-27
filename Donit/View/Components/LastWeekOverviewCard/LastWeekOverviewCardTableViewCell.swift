//
//  LastWeekOverviewCardTableViewCell.swift
//  Donit
//
//  Created by Paulo José on 23/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class LastWeekOverviewCardTableViewCell: UITableViewCell {

    var lastWeek: Week!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var progressBarWrapperView: UIView!

    @IBOutlet var progressBars: [ProgressBarWithLabel]!
    @IBOutlet var progressBarLeadingConstraints: [NSLayoutConstraint]!
    @IBOutlet var progressBarTopConstraints: [NSLayoutConstraint]!

    @IBOutlet weak var progressBarWrapperTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        guard
            let days = lastWeek.days
            else { return }
        
        var lastWeekDays = days.array as? [Day]
        
        let progressBarsReversed = progressBars.reversed()
        var topConstraintsReversed = [NSLayoutConstraint]()
        
        var maxDoneItemCount = 0
        var referenceValue: CGFloat = 10.0
        
        let wrapperHeight = progressBarWrapperView.frame.height
        
        for arrayIndex in 0..<progressBarTopConstraints.count {
            topConstraintsReversed.append(progressBarTopConstraints[(progressBarTopConstraints.count - 1) - arrayIndex])
        }
        
       
        
        
        for day in lastWeekDays! {
            if day.doneItems?.count ?? 0 > maxDoneItemCount {
                maxDoneItemCount = day.doneItems?.count ?? 0
            }
        }
        
        if maxDoneItemCount > 10 && maxDoneItemCount <= 25 {
            referenceValue = 25
        } else if maxDoneItemCount > 25 && maxDoneItemCount <= 50 {
            referenceValue = 50
        } else if maxDoneItemCount > 50 {
            referenceValue = 100
        }
        
       
        for (index,day) in lastWeekDays!.enumerated() {
            var dayOfTheWeek = ""
            
            switch index {
                case 0:
                    dayOfTheWeek = "S"
                case 1:
                    dayOfTheWeek = "M"
                case 2:
                    dayOfTheWeek = "T"
                case 3:
                    dayOfTheWeek = "W"
                case 4:
                    dayOfTheWeek = "T"
                case 5:
                    dayOfTheWeek = "F"
                case 6:
                    dayOfTheWeek = "S"
                default:
                    print("Error")
            }
            
            let count = CGFloat(day.doneItems?.count ?? 0)
            
            topConstraintsReversed[index].constant = wrapperHeight - ((count / referenceValue) * wrapperHeight)
            
//            topConstraintsReversed[index].constant = 50
//            
//            var constant = (CGFloat(referenceValue) * CGFloat(day.doneItems?.count ?? 0)) / wrapperHeight
//            print(constant)
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
