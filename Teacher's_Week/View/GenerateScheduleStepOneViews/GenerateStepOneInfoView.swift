//
//  GenerateStepOneInfoView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 06/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class GenerateStepOneInfoView:CustomView {
    
    
    let numberLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.MyTheme.lightBlue
        label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 35)
        label.text = "32"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    let textLabel:UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textColor = .white
           label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 40)
           label.text = "Students"
           label.adjustsFontSizeToFitWidth = true
           return label
       }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.MyTheme.lightBG
        setSubviews()
        setConstraints()
        
    }
    
    private func setSubviews() {
        addSubview(numberLabel)
        addSubview(textLabel)
    }
    
    private func setConstraints() {
        let padding = DeviceConfigurations.windowHeight / 45
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-|", views: numberLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-|", views: textLabel)
        addConstraintsWithFormat(format: "V:|-\(padding)-[v0]-\(padding)-[v1]-\(padding)-|", views: numberLabel,textLabel)
        
        numberLabel.heightAnchor.constraint(equalTo: textLabel.heightAnchor, multiplier: 1.5).isActive = true
        
    }
    
}
