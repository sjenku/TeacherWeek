//
//  GenerateStepOneInfoContainer.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 06/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class GenerateStepOneInfoContainer : CustomView {
    
    
    
    let studentsInfoView:GenerateStepOneInfoView = {
        let v = GenerateStepOneInfoView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let middleLine:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let groupsInfoView:GenerateStepOneInfoView = {
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
        let stackView = UIStackView(arrangedSubviews: [self.studentsInfoView,self.groupsInfoView])
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
        studentsInfoView.addSubview(middleLine)
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: shadowView)
        
        let additionalConstraints = [
            shadowView.heightAnchor.constraint(equalTo:self.heightAnchor ,multiplier: 1/2),
            shadowView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            infoStack.topAnchor.constraint(equalTo: shadowView.topAnchor),
            infoStack.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            infoStack.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            infoStack.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            
            
            middleLine.trailingAnchor.constraint(equalTo: studentsInfoView.trailingAnchor),
            middleLine.widthAnchor.constraint(equalToConstant: 0.5),
            middleLine.centerYAnchor.constraint(equalTo: studentsInfoView.centerYAnchor),
            middleLine.heightAnchor.constraint(equalTo: studentsInfoView.heightAnchor, multiplier: 0.5)
            
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
