//
//  ScheduleResultsInfoView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class ScheduleResultsInfoView : CustomView {
    
    var profit:Int = 0 {
        willSet {
            profitInfoView.numberLabel.text = String(newValue) + "$"
        }
    }
    
    var lessons:Int = 0 {
        willSet {
            lessonsInfoView.numberLabel.text = String(newValue)
        }
    }
    
    var successProcentege:Int = 0 {
        willSet {
            successInfoView.numberLabel.text = String(newValue) + "%"
        }
    }
    
    private let profitInfoView:GenerateStepOneInfoView = {
        let v = GenerateStepOneInfoView()
        v.textLabel.text = "Profit"
        v.numberLabel.text = "0"
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let lessonsInfoView:GenerateStepOneInfoView = {
        let v = GenerateStepOneInfoView()
        v.textLabel.text = "Lessons"
        v.numberLabel.text = "0"
        return v
    }()
    
    private let successInfoView:GenerateStepOneInfoView = {
        let v = GenerateStepOneInfoView()
        v.textLabel.text = "Success"
        v.numberLabel.text = "0"
        return v
    }()
    
    
    private let leftLine:UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = .lightGray
         return view
     }()
     
     private let rightLine:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray
            return view
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
