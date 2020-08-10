//
//  GroupInfoVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 04/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GroupInfoVC:UIViewController {
    
    //MARK: - Properties
    
    var group:Group = Group() {
        didSet {
            let cellsInfo:[CellInfo] = group.students.map {
                return CellInfo(title: $0.firstName + " " + $0.lastName, subtitle: "", isAccessory: $0.checked, relatedTo: $0)
            }
            let sectionInfo = SectionInfo(headerTitle: "", cellsInfo: cellsInfo)
            groupName.text = group.groupName
            studentList.updateInfo([sectionInfo])
        }
    }
    
   private let groupIconView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "groupGreen")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.MyTheme.lightBlue
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
   private let studentList:ListCollectionView = {
        let view = ListCollectionView(frame: .zero, info: nil, style: CellStyle.title)
        return view
    }()
    
    
    //TODO:Create extension to UILabel for repeating configurations
   private let groupName:UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.adjustsFontSizeToFitWidth = true
          label.text = ""
          label.textAlignment = .center
          label.textColor = .white
          label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 28)
          return label
      }()
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setNavigationItem()
        setSubviews()
        setConstraints()
        
    }
    
    //MARK: - Private Methods
    
    private func setNavigationItem() {
        navigationController?.topViewController?.navigationItem.largeTitleDisplayMode = .never
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
