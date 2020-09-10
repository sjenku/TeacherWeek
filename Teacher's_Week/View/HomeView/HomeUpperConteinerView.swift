//
//  HomeUpperConteinerView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class HomeUpperConteinerView:CustomView {
    
    private let padding:CGFloat = 8
    
   private let line:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let profileImage:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "profileImage"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    private let profileTitle:UILabel = {
        let label = UILabel()
        label.text = "Abraham Abramson"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
     let imageSize = (UIApplication.shared.keyWindow?.screen.bounds.width ?? 375) / 7
    
    override func setupView() {
        
        backgroundColor = .clear
        
        //subviews
        addSubview(line)
        addSubview(profileImage)
        addSubview(profileTitle)
        
        //profileImage
        profileImage.layer.cornerRadius = imageSize / 2
        profileImage.layer.masksToBounds = true
        
        //profileTitle
        let profileTitleHeight = imageSize / 2
        profileTitle.font = UIFont.systemFont(ofSize: imageSize/2.5)
        
        //constraints
        addConstraintsWithFormat(format: "H:|-\(padding)-[v0]-\(padding)-|", views: line)
        addConstraintsWithFormat(format: "V:[v0(\(imageSize))]-\(padding * 2)-[v1(1)]|", views:profileImage, line)
        addConstraintsWithFormat(format: "H:|-\(padding * 1.2)-[v0(\(imageSize))]-8-[v1]-\(padding)-|", views: profileImage,profileTitle)
        addConstraintsWithFormat(format: "V:[v0(\(profileTitleHeight))]-\(padding * 2 + 1)-|", views: profileTitle)
        
        
        
        
    }

}
