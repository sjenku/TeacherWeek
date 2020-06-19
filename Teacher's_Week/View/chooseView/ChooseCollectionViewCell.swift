//
//  ChooseCollectionViewCell.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 19/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ChooseCollectionViewCell: CustomCollectionViewCell {
    
    let personNameLabel:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.text = "Student Name"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    override func setupView() {
        
        backgroundColor = UIColor.MyTheme.cellColor
        addSubview(personNameLabel)
        addConstraintsWithFormat(format:"H:|-16-[v0]|", views:personNameLabel)
        addConstraintsWithFormat(format:"V:|[v0]|", views: personNameLabel)
        
        
        
    }
}
