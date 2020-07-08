//
//  GenerateScheduleStepTwoVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 07/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GenerateScheduleStepTwoVC:UIViewController {
    
    let previousButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Previous", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
        return button
    }()
    
    let generateButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Generate", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
        return button
    }()
    
    lazy var previousGenerateButtonsSV:UIStackView = {
        [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.previousButton,self.generateButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        setSubviews()
        setConstraints()
        
    }
    
    private func setSubviews() {
        view.addSubview(previousGenerateButtonsSV)
    }
    
    private func setConstraints() {
        view.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: previousGenerateButtonsSV)
        let additionalConstraints = [
         previousGenerateButtonsSV.bottomAnchor.constraint(equalTo: (view.safeAreaLayoutGuide.bottomAnchor) ,constant: -8),
         previousGenerateButtonsSV.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * CGFloat(0.1))
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
