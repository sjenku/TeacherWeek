//
//  ExtensionDate.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 13/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


extension Date {
    
    
    var toString:String {
        get {
          let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: self)
        }
    }
    
   var zeroSeconds: Date? {
           let calendar = Calendar.current
           let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
           return calendar.date(from: dateComponents)
       }
    
}
