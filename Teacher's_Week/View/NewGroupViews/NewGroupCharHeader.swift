//
//  NewGroupCharHeader.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 01/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class DumbHeader:UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = UIColor.MyTheme.headerColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
