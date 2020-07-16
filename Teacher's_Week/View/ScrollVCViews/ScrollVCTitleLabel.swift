//
//  ScrollVCTitleLabel.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ScrollVCTitleLabel:UILabel {
    
    
    init(text:String) {
        super.init(frame:.zero)
        self.text = text
        setupLabel()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setupLabel()
    }
    

    private func setupLabel() {
        textColor = .white
        font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textAlignment = .center
    }
    
}
