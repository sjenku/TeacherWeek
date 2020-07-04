//
//  HeadTitleAndSubTitleView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 04/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class HeadTitleAndSubTitleView:CustomView {
    
    
      let headTitle:UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.adjustsFontSizeToFitWidth = true
          label.textAlignment = .center
          label.textColor = .lightGray
          label.text = "User Name"
          label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 35)
          return label
      }()
    
    let subTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = "Jhon"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 28)
        return label
    }()
    
    private func setConstraints() {
          addConstraintsWithFormat(format: "H:|[v0]|", views: headTitle)
          addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: subTitle)
          addConstraintsWithFormat(format: "V:|[v0]-4-[v1]|", views: headTitle,subTitle)
          headTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
      }
    
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.MyTheme.darkBG
        
        addSubview(headTitle)
        addSubview(subTitle)
        
        setConstraints()
        
    }
    
}
