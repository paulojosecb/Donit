//
//  WeeklyOverviewCardTableViewCell.swift
//  Donit
//
//  Created by Paulo José on 20/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

enum overviewMode {
    case lastWeek
    case sevenWeeks
}

class OverviewCardTableViewCell: UITableViewCell {
    
    var dataSource = [OverviewModel]()
    var mode: overviewMode = .lastWeek
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet var progressBars: [ProgressBar]!
    @IBOutlet weak var progressBarWrapperView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentLabelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBarWrapperTopConstraint: NSLayoutConstraint!
    @IBOutlet var progressBarsLeadingContraints: [NSLayoutConstraint]!
    @IBOutlet var progressBarsTopConstraints: [NSLayoutConstraint]!
    
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
        
        switch mode {
        case .lastWeek:
            commentLabel.text = " \(getAverage(with: dataSource)) things per day is your daily average this week"
        case .sevenWeeks:
            commentLabel.text = "\(getAverage(with: dataSource)) things per week is your weekly average in the last 7 weeks"
        }
        
        if progressBarWrapperView.frame.height > CGFloat(70.0) {
            progressBarWrapperTopConstraint.constant = 24
        }
    
    }
    
    override func draw(_ rect: CGRect) {
        calculateLeadingConstraints()
        calculateTopConstraints()
    }
    
    func calculateLeadingConstraints() {
        let newLeadingConstant = (progressBarWrapperView.frame.width - (progressBars[0].frame.width * CGFloat(progressBars.count))) / CGFloat(progressBars.count - 1)
        
        progressBarsLeadingContraints.forEach { (constrait) in
            constrait.constant = newLeadingConstant
        }
        
        cardView.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue])
        
        self.layoutIfNeeded()
    }
    
    func calculateTopConstraints() {
        
        var referenceValue: CGFloat = 10
        
        let maxValue = dataSource.reduce(0, {previous, data in
            return data.count > previous ? data.count : previous
        })
        
        if maxValue <= 10 {
            referenceValue = 10
        } else if maxValue > 10 && maxValue <= 25 {
            referenceValue = 25
        } else if maxValue > 25  && maxValue <= 50 {
            referenceValue = 50
        } else {
            referenceValue = CGFloat(maxValue)
        }
        
        let wrapperHeight = progressBarWrapperView.frame.height
        
        for (index, data) in dataSource.reversed().enumerated() {
            progressBarsTopConstraints[index].constant = wrapperHeight - ((CGFloat(data.count) / referenceValue) * wrapperHeight) - 23
            
            if progressBarsTopConstraints[index].constant == wrapperHeight {
                progressBarsTopConstraints[index].constant = wrapperHeight - 23
            } else if progressBarsTopConstraints[index].constant < 0 {
                progressBarsTopConstraints[index].constant = 0
            }
            
            progressBars[index].countLabel.text = "\(data.count)"
            
        }
        
        self.layoutIfNeeded()
                
    }
    
    func getAverage(with model: [OverviewModel]) -> Double {
        
        let average : Double = Double(model.reduce(0, { previous, data in
            return previous + data.count
        })) / Double(model.count)
        
        return average.rounded(toPlaces: 2)
    }
    
}
