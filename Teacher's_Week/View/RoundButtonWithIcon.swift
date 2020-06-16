//
//  RoundButtonWithIcon.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class RoundButtonWithIcon:UIButton {
    
    
    override var buttonType: UIButton.ButtonType {
        return ButtonType.custom
    }
    
    init(frame:CGRect,kind:StudentOrGroup) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.MyTheme.darkBG
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
