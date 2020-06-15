//
//  Colors.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



extension UIColor {
    
    static func rgb(red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    struct MyTheme {
        static let darkBG  = UIColor.rgb(red: 31, green: 37, blue: 50)
        static let lightBG = UIColor.rgb(red: 40, green: 48, blue: 66)
        static let lightBlue = UIColor.rgb(red: 50, green: 197, blue: 255)
        static let darkBlue = UIColor.rgb(red: 39, green: 73, blue: 109)
        static let lightGreen = UIColor.rgb(red: 100, green: 221, blue: 183)
        static let darkGreen = UIColor.rgb(red: 100, green: 212, blue: 0)
        static let yellowSchedule = UIColor.rgb(red: 247, green: 181, blue: 0)
        static let barsColor = UIColor.rgb(red: 22, green: 23, blue: 24)
    }
}
