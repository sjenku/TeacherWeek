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
    
    let firstNameInfo:HeadTitleAndSubTitleView = {
        let v = HeadTitleAndSubTitleView()
        v.headTitle.text = "First Name"
        v.subTitle.text = "Jhon"
        return v
    }()
    
    let lastNameInfo:HeadTitleAndSubTitleView = {
        let v = HeadTitleAndSubTitleView()
        v.headTitle.text = "Last Name"
        v.subTitle.text = "Smith"
        return v
    }()
    
    let phoneNumberInfo:HeadTitleAndSubTitleView = {
        let v = HeadTitleAndSubTitleView()
        v.headTitle.text = "Phone Number"
        v.subTitle.text = "054-12345678"
        return v
    }()
    
    let eMailInfo:HeadTitleAndSubTitleView = {
        let v = HeadTitleAndSubTitleView()
        v.headTitle.text = "Email"
        v.subTitle.text = "abc@gdm.com"
        return v
    }()
    
    
    
    
    
    lazy var stackView:UIStackView = {
        [unowned self] in
        let sv = UIStackView(arrangedSubviews: [self.firstNameInfo,self.lastNameInfo,self.phoneNumberInfo,self.eMailInfo])
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.backgroundColor = .blue
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
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
