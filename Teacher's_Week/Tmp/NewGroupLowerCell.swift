//
//  NewGroupLowerCell.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class NewGroupLowerCell:CustomCollectionViewCell {
    
    
    private let studentList:ListCollectionView = {
        let info:[SectionInfo] = ContactsManager.getSectionsInfo()
        let listCollectionView = ListCollectionView(frame:.zero,info:info)
        return listCollectionView
    }()
    
    let doneButton:ChooseLabelDoneBTView = {
        let bt = ChooseLabelDoneBTView()
        return bt
    }()
    
    override func setupView() {
        super.setupView()
        
        
        backgroundColor = UIColor.MyTheme.darkBG
        addSubview(studentList)
        addSubview(doneButton)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: studentList)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: doneButton)
        addConstraintsWithFormat(format: "V:|-[v0][v1]|", views: studentList,doneButton)
        addConstraint(NSLayoutConstraint(item: studentList, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 3/4, constant: 0))
    
        
    }
    
    
}
