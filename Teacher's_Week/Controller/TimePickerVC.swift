//
//  TimePickerVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class TimePickerVC:UIViewController {
    
    let nextButton:GenerateSOTitleBTView = {
           let button = GenerateSOTitleBTView(title: "Next", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        setSubviews()
        setConstraints()
        
    }
    
    private func setSubviews() {
        
        view.addSubview(nextButton)
        
    }
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: nextButton)
        
        let additionalConstraints = [
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1)
        ]
        
        additionalConstraints.forEach {$0.isActive = true}
    }
    
    
    
}
