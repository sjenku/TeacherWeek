//
//  ProfilePopUpVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 20/09/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ProfilePopUpVC:PopUpViewController {
    
    enum ChangeInModelValOf {
        case breaksDuration,lessonDuration,lessonPrice
    }
    
    var changerOf:ChangeInModelValOf!
    
    init(changerOf:ChangeInModelValOf) {
        super.init(nibName:nil, bundle:nil)
        self.changerOf = changerOf
        setContentView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentView() {
        switch changerOf {
        case .breaksDuration:
            self.contentView = SliderView(startValue: 45, maxValue: 120, sign: "min")
        case .lessonDuration:
            self.contentView = SliderView(startValue: 45, maxValue: 180, sign: "min")
        case .lessonPrice:
            self.contentView = SliderView(startValue: 0, maxValue: 500, sign: "$")
        case .none:
            fatalError("No ChangerOf Value")
        }
        
        self.contentView.backgroundColor = UIColor.MyTheme.darkBG
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.MyTheme.barsColor.cgColor
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func handleTap() {
        switch changerOf {
        case .breaksDuration:
            ProfileModel.DefaultSettings.breaksBetweenLessons = contentView.currentValue
        case .lessonDuration:
            ProfileModel.DefaultSettings.lessonDuration = contentView.currentValue
        case .lessonPrice:
            ProfileModel.DefaultSettings.lessonPrice = contentView.currentValue
        case .none:
            fatalError("No Value For ChangerOf")
        }
        super.handleTap()
    }
    
}
