//
//  HomeView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 15/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class HomeView:CustomView {
    
    let upperContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    var lowerContainer:HomeLowerContainerView = HomeLowerContainerView()
    
    
    override func setupView () {
        
        backgroundColor = UIColor.MyTheme.darkBG
        
        //Set Containers
        let padding:CGFloat = 16
        let heightUpperC = frame.height / 4.5
        let heightLowerC = frame.height - heightUpperC - padding
        
        addSubview(upperContainer)
        addSubview(lowerContainer)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: upperContainer)
        addConstraintsWithFormat(format: "V:|[v0(\(heightUpperC))]-\(padding)-[v1(\(heightLowerC))]", views: upperContainer,lowerContainer)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: lowerContainer)
        
    }
}

