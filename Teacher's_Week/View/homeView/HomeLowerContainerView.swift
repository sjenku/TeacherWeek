//
//  HomeLowerContainerView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class HomeLowerContainerView:CustomView {
    
   private let upperHalfStackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
   private let lowerHalfView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
   private let addScheduleButton:RoundButtonWithIcon = {
        let bt = RoundButtonWithIcon()
        return bt
    }()
    
   private let addStudentView:HomeAddView = HomeAddView(frame: .zero, kind: .student)
   private let addGroupView:HomeAddView = HomeAddView(frame: .zero, kind: .group)
    
   private let mainStackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    override func setupView() {
        backgroundColor = UIColor.MyTheme.lightBG
        
        //upperHalfStackView
        upperHalfStackView.addArrangedSubview(addStudentView)
        upperHalfStackView.addArrangedSubview(addGroupView)
        
        //mainStackView
        mainStackView.addArrangedSubview(upperHalfStackView)
        mainStackView.addArrangedSubview(lowerHalfView)
        
        addSubview(mainStackView)
        
        //constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: mainStackView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: mainStackView)
        
        //lowerHalfView
        setLowerHalfView()

    }
    
   private func setLowerHalfView() {
        //properties
        lowerHalfView.addSubview(addScheduleButton)
        addScheduleButton.btImageView.image = UIImage(named: "scheduleAdd")?.withRenderingMode(.alwaysOriginal)
        addScheduleButton.isHighlightedColor = UIColor.MyTheme.yellowSchedule.highlight
        addScheduleButton.contentMode = .scaleAspectFit
        addScheduleButton.shadowColor = UIColor.MyTheme.yellowSchedule
        
        //layout
        let width = (UIApplication.shared.keyWindow?.screen.bounds.width ?? 375) / 3
        lowerHalfView.addConstraintsWithFormat(format: "H:[v0(\(width))]", views: addScheduleButton)
        lowerHalfView.addConstraintsWithFormat(format: "V:[v0(\(width))]", views: addScheduleButton)
        lowerHalfView.addConstraint(NSLayoutConstraint(item: addScheduleButton, attribute: .centerX, relatedBy: .equal, toItem: lowerHalfView, attribute: .centerX, multiplier: 1, constant: 0))
        lowerHalfView.addConstraint(NSLayoutConstraint(item: addScheduleButton, attribute: .centerY, relatedBy: .equal, toItem: lowerHalfView, attribute: .centerY, multiplier: 1, constant: 0))
    }
    

}

