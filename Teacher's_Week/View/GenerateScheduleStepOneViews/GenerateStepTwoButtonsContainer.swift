//
//  GenerateStepTwoButtonsContainer.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 07/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GenerateStepTwoButtonsContainer:CustomView {
    
    private let switchContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let label:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 30, weight: .light)
        l.adjustsFontSizeToFitWidth = true
        l.textColor = .lightGray
        l.textAlignment = .left
        l.text = "Maximize Profit"
        return l
    }()
    
    private lazy var switchController:UISwitch = {
        let switchC = UISwitch()
        switchC.tintColor = .lightGray
        switchC.onTintColor = .orange
        switchC.translatesAutoresizingMaskIntoConstraints = false
        return switchC
    }()
    
  
    
    private let line:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    

     let generateButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Generate", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
        return button
    }()

    
    override func setupView() {
        super.setupView()
        
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        switchContainer.addSubview(label)
        switchContainer.addSubview(switchController)
        addSubview(switchContainer)
        addSubview(line)
        addSubview(generateButton)
        
    }
    
    private func setConstraints() {
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: generateButton)
        addConstraintsWithFormat(format: "H:|[v0]|", views: line)
        addConstraintsWithFormat(format: "H:|[v0]|", views: switchContainer)
        addConstraintsWithFormat(format: "V:|[v0][v1(0.5)][v2]|", views: switchContainer,line,generateButton)
        
        let additionalConstraints = [
            generateButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            switchController.trailingAnchor.constraint(equalTo: switchContainer.trailingAnchor,constant: -8),
            switchController.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),
            
            label.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: switchContainer.leadingAnchor,constant: 8),
            label.trailingAnchor.constraint(equalTo: switchController.leadingAnchor,constant: -8),
            label.heightAnchor.constraint(equalTo: switchContainer.heightAnchor, multiplier: 0.5)
            
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    
    
}
