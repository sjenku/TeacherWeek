//
//  ChooseCollectionHeaderView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 19/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ChooseCollectionHeaderView: UICollectionReusableView {
        
    
    let charLabel:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .lightGray
        return label
    }()
    
    var char:Character? {
        willSet {
            guard let safeChar = newValue else {return}
            charLabel.text = String(safeChar)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = UIColor.MyTheme.headerColor
        addSubview(charLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: charLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: charLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
