//
//  GenerateStepOneInfoContainer.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 06/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class GenerateStepOneInfoView:CustomView {
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.MyTheme.lightBG
    }
    
}

class GenerateStepOneInfoContainer : CustomView {
    
    
    
    let view:GenerateStepOneInfoView = {
        let v = GenerateStepOneInfoView()
        return v
    }()
    
    
    let shadowView:UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.layer.shadowOpacity = 0.3
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = .zero
        return view
    }()
    

    
    private lazy var infoStack:UIStackView = {
        [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.view,self.view])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.clear
        setSubviews()
        setConstraints()
        
    }
    

    
    private func setSubviews() {
        shadowView.addSubview(infoStack)
        addSubview(shadowView)
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: shadowView)
        
        let additionalConstraints = [
            shadowView.heightAnchor.constraint(equalTo:self.heightAnchor ,multiplier: 1/2),
            shadowView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            infoStack.topAnchor.constraint(equalTo: shadowView.topAnchor),
            infoStack.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            infoStack.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            infoStack.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)
            
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
