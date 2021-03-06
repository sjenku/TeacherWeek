//
//  ChooseLabelDoneBTView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ChooseLabelDoneBTView:RectButtonWithTitleView {
    

    override func setConstraints() {
        super.setConstraints()
        addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.45, constant: 0))
        addConstraint(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    

}
