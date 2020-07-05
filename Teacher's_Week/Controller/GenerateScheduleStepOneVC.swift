//
//  GenerateScheduleStepOneVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 05/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class GenerateScheduleStepOneVC:UIViewController {
    
    
    let buttonsContainer:GenerateStepOneButtonsContainer = {
        let view = GenerateStepOneButtonsContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.MyTheme.lightBG
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        setSubviews()
        setConstriants()
        
    }
    
    private func setSubviews() {
        view.addSubview(buttonsContainer)
    }
    
    private func setConstriants() {
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: buttonsContainer)
        
        let additionalConstraints = [
            buttonsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsContainer.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.55)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}
