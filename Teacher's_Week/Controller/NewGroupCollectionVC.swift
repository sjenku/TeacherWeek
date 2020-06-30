//
//  NewGroupViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class NewGroupCollectionVC:UIViewController {
    
    //MARK: - Views
    let lowerContainer:NewGroupLowerContrainerView = {
        let view = NewGroupLowerContrainerView()
        return view
    }()
    
    
    let upperContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubview()
        setConstriants()
    }
    

    //MARK: - Private Functions
    
    private func setSubview() {
        view.addSubview(upperContainer)
        view.addSubview(lowerContainer)
    }
    
    private func setConstriants() {
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: upperContainer)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerContainer)
        view.addConstraintsWithFormat(format: "V:|[v0][v1]", views: upperContainer,lowerContainer)
        view.addConstraint(NSLayoutConstraint(item: lowerContainer, attribute: .height, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 0.4, constant: 0))
        lowerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -8).isActive = true
        
    }
}
