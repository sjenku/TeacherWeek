//
//  TitleAndSwitchView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class TitleAndSwitchView:CustomView {
    
    private let switchController:UISwitch = {
           let switchC = UISwitch()
           switchC.tintColor = .lightGray
           switchC.onTintColor = UIColor.MyTheme.lightGreen
           switchC.translatesAutoresizingMaskIntoConstraints = false
           return switchC
       }()
    
    private let title:ScrollVCTitleLabel = ScrollVCTitleLabel(text: "need breaks?")
    
    private let line:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        setSubviews()
        setConstraints()
    }
    
    
    
    private func setSubviews() {
        addSubview(switchController)
        addSubview(title)
        addSubview(line)
    }
    
    private func setConstraints() {
        
        addConstraintsWithFormat(format: "H:|-24-[v0]", views: title)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: line)
        
        let constraints = [
            switchController.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            switchController.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24),
            
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5)
        ]
        
        constraints.forEach {$0.isActive = true}
    }
}
