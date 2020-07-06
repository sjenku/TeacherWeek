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
    
    let infoContainer:GenerateStepOneInfoContainer = {
        let view = GenerateStepOneInfoContainer()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstriants()
        
    }
    
    private func setSubviews() {
        view.addSubview(buttonsContainer)
        view.addSubview(infoContainer)
    }
    
    private func setConstriants() {
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: buttonsContainer)
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: infoContainer)
        
        let additionalConstraints = [
            buttonsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsContainer.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.55),
            
            infoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoContainer.bottomAnchor.constraint(equalTo: buttonsContainer.topAnchor)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}
