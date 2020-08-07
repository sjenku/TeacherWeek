//
//  StudentInfoVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 04/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class StudentInfoVC:UIViewController {
    
    //MARK: - Private Properties
   private let circleStudentIcon:UIImageView = {
          let iv = UIImageView()
          iv.image = UIImage(named: "circle.person")
          iv.contentMode = .scaleAspectFit
          return iv
      }()
    
   private let firstNameInfo:HeadTitleAndSubTitleView = {
        let v = HeadTitleAndSubTitleView()
        v.headTitle.text = "First Name"
        return v
    }()
    
   private let lastNameInfo:HeadTitleAndSubTitleView = {
        let v = HeadTitleAndSubTitleView()
        v.headTitle.text = "Last Name"
        return v
    }()
    
   private let phoneNumberInfo:HeadTitleAndSubTitleView = {
        let v = HeadTitleAndSubTitleView()
        v.headTitle.text = "Phone Number"
        return v
    }()
    
   private let eMailInfo:HeadTitleAndSubTitleView = {
        let v = HeadTitleAndSubTitleView()
        v.headTitle.text = "Email"
        return v
    }()
    
    
   private lazy var stackView:UIStackView = {
        [unowned self] in
        let sv = UIStackView(arrangedSubviews: [self.firstNameInfo,self.lastNameInfo,self.phoneNumberInfo,self.eMailInfo])
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.backgroundColor = .blue
        return sv
    }()
    //MARK: - Initializetion
    init(firstName:String?,lastName:String?,phoneNumber:String?,eMail:String?) {
        super.init(nibName: nil, bundle: nil)
        firstNameInfo.subTitle.text = firstName ?? ""
        lastNameInfo.subTitle.text = lastName ?? ""
        phoneNumberInfo.subTitle.text = phoneNumber ?? ""
        eMailInfo.subTitle.text = eMail ?? ""
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstraints()
        setNavigationItem()
    }
    
    //MARK: - Private Methods
    private func setNavigationItem() {
        navigationController?.topViewController?.navigationItem.largeTitleDisplayMode = .never
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
