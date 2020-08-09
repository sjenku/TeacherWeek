//
//  HomeLowerContainerView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


protocol HomeLowerContainerViewDelegate :class {
    func addScheduleButtonPressed()
    func addStudentButtonPressed()
    func addGroupButtonPressed()
}

class HomeLowerContainerView:CustomView {
    
   //MARK: - Properties
   weak var delegate:HomeLowerContainerViewDelegate?
    
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
    
   private lazy var addScheduleButton:RoundButtonWithIcon = {
        let bt = RoundButtonWithIcon()
        bt.circleButton.addTarget(self, action: #selector(handleAddScheduleButton), for: .touchUpInside)
        return bt
    }()
    
    private lazy var addStudentView:HomeAddView = {
        let view =  HomeAddView(frame: .zero, kind: .student)  //TODO:refactor for better implementation
        view.addButton.circleButton.addTarget(self, action: #selector(handleAddStudentButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var addGroupView:HomeAddView = {
       let view = HomeAddView(frame: .zero, kind: .group)
        view.addButton.circleButton.addTarget(self, action: #selector(handleAddGroupButton), for: .touchUpInside)
        return view
    }()
    
   private let mainStackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    //MARK: - Public Methods
    func updateAddStudentViewCounter(number:Int) {
        addStudentView.counterLabel.text = String(number)
    }
    
    func updateAddGroupViewCounter(number:Int) {
        addGroupView.counterLabel.text = String(number)
    }
    
    //MARK: - OBJC private Functions
    @objc private func handleAddGroupButton() {
        delegate?.addGroupButtonPressed()
    }
    
    @objc private func handleAddScheduleButton() {
        delegate?.addScheduleButtonPressed()
      }
    
    @objc private func handleAddStudentButton() {
          delegate?.addStudentButtonPressed()
        }
    
   //MARK: - Override Functions
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
    
    //MARK: - Private Functions
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

