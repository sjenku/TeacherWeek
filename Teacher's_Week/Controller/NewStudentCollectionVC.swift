//
//  NewStudentCollectionVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 02/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class NewStudentCollectionVC:UIViewController {
    
    
    let doneButton:ChooseLabelDoneBTView = {
        let bt = ChooseLabelDoneBTView()
        return bt
    }()
    
    
    let damnView:UIView = {
       let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    
    let circleStudentIcon:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "circle.person")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .brown
        view.addSubview(circleStudentIcon)
        view.addSubview(damnView)
        view.addSubview(doneButton)
        setConstraints()
        
    }
    
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: circleStudentIcon)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: damnView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: doneButton)
        view.addConstraintsWithFormat(format: "V:[v0][v1][v2]", views: circleStudentIcon,damnView,doneButton)
        
        let additionalConstraints = [
        circleStudentIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        circleStudentIcon.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
        
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        doneButton.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    
    
}
