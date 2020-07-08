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
    
    private let previousButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Previous", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
        return button
    }()

    private let generateButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Generate", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
        return button
    }()

    private lazy var previousGenerateButtonsSV:UIStackView = {
        [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.previousButton,self.generateButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
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
        addSubview(previousGenerateButtonsSV)
        
    }
    
    private func setConstraints() {
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: previousGenerateButtonsSV)
        addConstraintsWithFormat(format: "H:|[v0]|", views: line)
        addConstraintsWithFormat(format: "H:|[v0]|", views: switchContainer)
        addConstraintsWithFormat(format: "V:|[v0][v1(0.5)][v2]|", views: switchContainer,line,previousGenerateButtonsSV)
        
        let additionalConstraints = [
            previousGenerateButtonsSV.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            switchController.trailingAnchor.constraint(equalTo: switchContainer.trailingAnchor,constant: -8),
            switchController.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),
//            switchController.heightAnchor.constraint(equalTo: switchContainer.heightAnchor, multiplier: 0.5),
            
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
