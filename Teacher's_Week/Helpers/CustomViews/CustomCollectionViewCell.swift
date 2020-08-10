//
//  CustomCollectionViewCell.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 02/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit
import SwipeCellKit



class CustomCollectionViewCell:SwipeCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        
        setupView()
    }
    
    func setupView() {
    }
}
