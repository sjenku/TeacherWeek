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
    
    static func rgb(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat) -> UIColor {
           return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
       }
    
    var highlight:UIColor {
        get {
            var redValue: CGFloat{ return CIColor(color: self).red }
            var greenValue: CGFloat{ return CIColor(color: self).green }
            var blueValue: CGFloat{ return CIColor(color: self).blue }
            return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 0.3)
        }
    }
    
    struct MyTheme {
        static let darkBG  = UIColor.rgb(red: 31, green: 37, blue: 50)
        static let lightBG = UIColor.rgb(red: 40, green: 48, blue: 66)
        static let lightBlue = UIColor.rgb(red: 50, green: 197, blue: 255)
        static let darkBlue = UIColor.rgb(red: 39, green: 73, blue: 109)
        static let titleBlue = UIColor.rgb(red: 50, green: 197, blue: 255)
        static let lightGreen = UIColor.rgb(red: 100, green: 221, blue: 183)
        static let shadowGreen = UIColor.rgb(red: 109, green: 212, blue: 0)
        static let titleGreen = UIColor.rgb(red: 109, green: 212, blue: 0)
        static let darkGreen = UIColor.rgb(red: 60, green: 103, blue: 31)
        static let yellowSchedule = UIColor.rgb(red: 247, green: 181, blue: 0)
        static let barsColor = UIColor.rgb(red: 22, green: 23, blue: 24)
        static let cellColor = UIColor.rgb(red: 58, green: 58, blue: 60)
        static let headerColor = UIColor.rgb(red: 31, green: 34, blue: 40)
        static let textFieldColor = UIColor.rgb(red: 209, green: 209, blue: 214)
        static let addStundentButtonColor = UIColor.rgb(red: 39, green: 73, blue: 109)
        static let deselectItemColor = UIColor.rgb(red: 112, green: 50, blue: 50)
    }
}
