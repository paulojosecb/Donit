//
//  Double.swift
//  Donit
//
//  Created by Paulo José on 28/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
