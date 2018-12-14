//
//  DoneItemCardTableViewCell.swift
//  Donit
//
//  Created by Paulo José on 14/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class DoneItemCardTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.addRoundedBorder(in: .opaque, colors: [UIColor.white])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
