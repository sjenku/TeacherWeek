//
//  ChooseLabelView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class ChooseLabelView:CustomView {
    
    private let labelView:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "Check all students that you would like to add"
        label.textColor = .lightGray
        return label
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.MyTheme.darkBG
        
        addSubview(labelView)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: labelView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: labelView)
        
    }
}


