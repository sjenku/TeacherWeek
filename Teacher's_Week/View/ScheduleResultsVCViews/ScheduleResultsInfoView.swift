//
//  ScheduleResultsInfoView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class ScheduleResultsInfoView : CustomView {
    
    
    
    let profitInfoView:GenerateStepOneInfoView = {
        let v = GenerateStepOneInfoView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let leftLine:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
     let rightLine:UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .lightGray
           return view
       }()
    
    
    let lessonsInfoView:GenerateStepOneInfoView = {
           let v = GenerateStepOneInfoView()
           return v
       }()
    
    let successInfoView:GenerateStepOneInfoView = {
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
        let stackView = UIStackView(arrangedSubviews: [self.profitInfoView,self.lessonsInfoView,self.successInfoView])
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
        profitInfoView.addSubview(leftLine)
        lessonsInfoView.addSubview(rightLine)
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: shadowView)
        
        let additionalConstraints = [
            shadowView.heightAnchor.constraint(equalTo:self.heightAnchor ,multiplier: 1),
            shadowView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            infoStack.topAnchor.constraint(equalTo: shadowView.topAnchor),
            infoStack.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            infoStack.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            infoStack.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            
            
            leftLine.trailingAnchor.constraint(equalTo: profitInfoView.trailingAnchor),
            leftLine.widthAnchor.constraint(equalToConstant: 0.5),
            leftLine.centerYAnchor.constraint(equalTo: profitInfoView.centerYAnchor),
            leftLine.heightAnchor.constraint(equalTo: profitInfoView.heightAnchor, multiplier: 0.5),
            
            rightLine.trailingAnchor.constraint(equalTo: lessonsInfoView.trailingAnchor),
            rightLine.widthAnchor.constraint(equalToConstant: 0.5),
            rightLine.centerYAnchor.constraint(equalTo: lessonsInfoView.centerYAnchor),
            rightLine.heightAnchor.constraint(equalTo: lessonsInfoView.heightAnchor, multiplier: 0.5)
            
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
