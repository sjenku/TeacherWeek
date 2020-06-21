//
//  ChooseCollectionHeaderView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 19/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ChooseCollectionHeaderView: UICollectionReusableView {
        
    
    let labelView:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .lightGray
        label.text = ""
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = UIColor.MyTheme.headerColor
        addSubview(labelView)
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: labelView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: labelView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
