//
//  ChooseLabelDoneBTView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ChooseLabelDoneBTView:CustomView {
    
    let doneButton:UIButton = {
        let bt = UIButton(type: .system)
        bt.backgroundColor = UIColor.MyTheme.lightGreen.highlight
        bt.layer.cornerRadius = 10
        bt.setTitle("Done", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.tintColor = UIColor.MyTheme.lightGreen
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.MyTheme.darkBG
        
        addSubview(doneButton)
        addConstraint(NSLayoutConstraint(item: doneButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: doneButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: doneButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: doneButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    
}
