//
//  GenerateScheduleStepTwoVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 07/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GenerateScheduleStepTwoVC:UIViewController {

    let buttonsContainer:GenerateStepTwoButtonsContainer = {
        let container = GenerateStepTwoButtonsContainer()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        setSubviews()
        setConstraints()
        
    }
    
    private func setSubviews() {
        view.addSubview(buttonsContainer)
    }
    
    private func setConstraints() {
        view.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: buttonsContainer)
        
        let additionalConstraints = [
            buttonsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            buttonsContainer.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.2)
        ]
        
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
