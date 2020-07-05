//
//  GenerateStepOneButtonsContainer.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 05/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GenerateStepOneButtonsContainer:CustomView {
    
    let resetButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Reset", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
        return button
    }()
    
    let nextButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Next", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
           return button
    }()
    
    
    lazy var resetNextButtonsSV:UIStackView = {
        [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.resetButton,self.nextButton])
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
        addSubview(resetNextButtonsSV)
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: resetNextButtonsSV)
        
        
        let additionalConstraints = [
        resetNextButtonsSV.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16),
        resetNextButtonsSV.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
