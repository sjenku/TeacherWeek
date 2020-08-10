//
//  NewGroupStudentCell.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 01/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class NewGroupStudentCell:UICollectionViewCell {
    
    override init(frame: CGRect) {
         super.init(frame:frame)
         
         setupView()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder:coder)
         
         setupView()
     }
    
    let profileIconView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "circle.person")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let fullNameTitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        let fontSize = DeviceConfigurations.windowHeight / 40
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        label.textColor = .lightGray
        label.text = "User FullName"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     func setupView() {
        
        backgroundColor = UIColor.MyTheme.lightBG
        
        addSubview(profileIconView)
        addSubview(fullNameTitle)
        setConstraints()
        
    }
    
    
    private func setConstraints() {
        
        profileIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/5, constant: 0).isActive = true
        profileIconView.widthAnchor.constraint(equalTo: profileIconView.heightAnchor).isActive = true
        profileIconView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -10).isActive = true
        
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: fullNameTitle)
        addConstraintsWithFormat(format: "V:[v0]-2-[v1]-|", views: profileIconView,fullNameTitle)
        
    }
   
    
    private var selectedHelper = false
    override var isSelected: Bool {
        get {
           return selectedHelper
            }
        set {
            if newValue {
                selectedHelper = true
                backgroundColor = UIColor.MyTheme.deselectItemColor
            } else {
                selectedHelper = false
                backgroundColor = UIColor.MyTheme.lightBG
            }
        }
    }
    
    
}

