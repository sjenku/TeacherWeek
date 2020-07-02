//
//  Extensions.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 15/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



extension UIView {
    
    func addConstraintsWithFormat(format:String,views:UIView...) {
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated() {
           let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: viewsDictionary))
    }
    
}


