//
//  GroupInfoVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 04/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GroupInfoVC:UIViewController {
    
    
    let groupIconView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "groupGreen")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.MyTheme.lightBlue
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    let studentList:ListCollectionView = {
        let info:[SectionInfo] = ContactsManager.getSectionsInfo()
        let view = ListCollectionView(frame: .zero, info: info, style: CellStyle.title)
        return view
    }()
    
    
    //TODO:Create extension to UILabel for repeating configurations
    let groupName:UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.adjustsFontSizeToFitWidth = true
          label.text = "Tigers"
          label.textAlignment = .center
          label.textColor = .white
          label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 28)
          return label
      }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstraints()
        
    }
    
    
    private func setConstraints() {
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: groupIconView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: groupName)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: studentList)
        
        let additionalConstraints = [
            groupIconView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            groupIconView.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
            
            groupName.topAnchor.constraint(equalTo: groupIconView.bottomAnchor,constant: 16),
            groupName.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 22),
            
            studentList.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 32),
            studentList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -DeviceConfigurations.windowHeight * 0.1)
            
            
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
    private func setSubviews() {
        view.addSubview(groupIconView)
        view.addSubview(groupName)
        view.addSubview(studentList)
    }
    
    
}
