//
//  ManageListLessonsView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class ManageListLessonsView:CustomView {
    
    let addButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Add", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let listOfLessons:ListCollectionView = {
        let info = ContactsManager.getSectionsInfo()
        let list = ListCollectionView(frame:.zero,info:info,style:CellStyle.subtitle)
        list.translatesAutoresizingMaskIntoConstraints = false
       return list
    }()
    
    private let doneButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Done", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupView() {
        super.setupView()
     
        setSubviews()
        setConstraints()
        
    }
    
    private func setSubviews() {
        addSubview(addButton)
        addSubview(listOfLessons)
        addSubview(doneButton)
    }
    
    private func setConstraints() {
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: listOfLessons)
        
        let additionalConstraints = [
            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            addButton.topAnchor.constraint(equalTo: self.topAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            
            doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            doneButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            
            listOfLessons.topAnchor.constraint(equalTo: addButton.bottomAnchor,constant: 8),
            listOfLessons.bottomAnchor.constraint(equalTo: doneButton.topAnchor,constant: -8)
            
        ]
        
        additionalConstraints.forEach {$0.isActive = true}
    }
    
    
}
