//
//  Date+Extension.swift
//  HomeReport
//
//  Created by Marcelo Mogrovejo on 5/30/17.
//  Copyright © 2017 Marcelo Mogrovejo. All rights reserved.
//

import Foundation

extension Date {
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: self)
    }
    
}
