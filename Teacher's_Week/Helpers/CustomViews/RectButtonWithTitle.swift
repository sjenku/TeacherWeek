//
//  RectButtonWithTitleView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 05/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class RectButtonWithTitleView:CustomView {
    
    init(title:String,backgroundColor:UIColor,tintColor:UIColor) {
        super.init(frame: .zero)
        
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.tintColor = tintColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let button:UIButton = {
        let bt = UIButton(type: .system)

        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.layer.shadowOpacity = 0.4
        bt.layer.cornerRadius = 5
        bt.layer.shadowOffset = .zero
        
        return bt
    }()
    

    
    override func setupView() {
          super.setupView()
          
          backgroundColor = UIColor.clear
          addSubview(button)
          setConstraints()
      }
    
     func setConstraints() {
    }
}
