//
//  StudentInfoVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 04/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class StudentInfoVC:UIViewController {
    
    
    let circleStudentIcon:UIImageView = {
          let iv = UIImageView()
          iv.image = UIImage(named: "circle.person")
          iv.contentMode = .scaleAspectFit
          return iv
      }()
    
    let viewtmp:UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    lazy var stackView:UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.viewtmp])
        sv.backgroundColor = .blue
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setSubviews()
        setConstraints()
    }
    
    
    private func setSubviews() {
        view.addSubview(circleStudentIcon)
        view.addSubview(stackView)
    }
    
    private func setConstraints() {
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: circleStudentIcon)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: stackView)
        view.addConstraintsWithFormat(format: "V:[v0]-8-[v1]", views: circleStudentIcon,stackView)
        
        let additionalConstraints = [
        circleStudentIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        circleStudentIcon.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
            
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -DeviceConfigurations.windowHeight * 0.1)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
