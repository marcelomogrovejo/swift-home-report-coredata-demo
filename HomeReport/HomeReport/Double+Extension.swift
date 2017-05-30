//
//  Double+Extension.swift
//  HomeReport
//
//  Created by Marcelo Mogrovejo on 5/30/17.
//  Copyright © 2017 Marcelo Mogrovejo. All rights reserved.
//

import Foundation

extension Double {
    
    var currencyFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
