//
//  ListViewCellSubtitle.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 21/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ListViewCellSubtitleDetail:ListViewCellSubtitle {
    override func setupView() {
        super.setupView()
        accessory.image = UIImage(named: "arrow.right")?.withRenderingMode(.alwaysOriginal)
    }
}

class ListViewCellSubtitle:ListViewCell {
    
    
    let subTitle:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .lightGray
        label.text = "10:00am-11:00am"
        return label
    }()
    
    override func setupView() {
        
        backgroundColor = UIColor.MyTheme.cellColor
        addSubview(title)
        addSubview(subTitle)
        addSubview(accessory)
        
        //Horizontal Title & Accessory
        addConstraintsWithFormat(format: "H:|-16-[v0][v1]-16-|", views: title,accessory)
        addConstraintsWithFormat(format: "H:|-16-[v0]", views: subTitle)
        addConstraintsWithFormat(format: "V:|[v0][v1]-8-|", views: title,subTitle)
        addConstraintsWithFormat(format: "V:|-19.5-[v0]-19.5-|", views: accessory)
        //TODO
        
        //Width Accessory
        addConstraint(NSLayoutConstraint(item: accessory, attribute: .width, relatedBy: .equal, toItem: accessory, attribute: .height, multiplier: 1, constant: 0))
        
        //Width Subtitle
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .trailing, relatedBy: .equal, toItem: accessory, attribute: .leading, multiplier: 1, constant: 0))
        
        //Height SubTitle
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .height, relatedBy: .equal, toItem: title, attribute: .height, multiplier: 1/3, constant: 0))
    }
    
}
