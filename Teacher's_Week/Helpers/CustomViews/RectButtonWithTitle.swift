//
//  RectButtonWithTitle.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 05/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class RectButtonWithTitle:CustomView {
    
    let doneButton:UIButton = {
        let bt = UIButton(type: .system)
        
        bt.backgroundColor = UIColor.MyTheme.darkGreen
        bt.setTitle("Done", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.tintColor = UIColor.MyTheme.titleGreen
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.layer.shadowOpacity = 0.4
        bt.layer.cornerRadius = 5
        bt.layer.shadowOffset = .zero
        
        return bt
    }()
    
    override func setupView() {
          super.setupView()
          
          backgroundColor = UIColor.MyTheme.darkBG
          addSubview(doneButton)
          setConstraints()
      }
    
     func setConstraints() {
    }
}
