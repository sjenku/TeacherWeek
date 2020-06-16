//
//  HomeAddView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class HomeAddView:UIView {
    
   private let leftContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   private let centerContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
   private let rightContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
   private let stackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
   private var padding:CGFloat  {
        if let height = UIApplication.shared.keyWindow?.screen.bounds.height {
           return CGFloat(height / 23)
        }
        return 0
    }
    
    
    init(frame: CGRect,kind:StudentOrGroup) {
        super.init(frame: frame)
        
        setupView(kind: kind)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   private func handleKind(_ kind:StudentOrGroup) {
        switch kind {
        case .student:
            imageView.image = UIImage(named: "personBlue")?.withRenderingMode(.alwaysOriginal)
            imageViewTitle.textColor = UIColor.MyTheme.lightBlue
            imageViewTitle.text = StudentOrGroup.student.rawValue
            counterLabel.textColor = UIColor.MyTheme.lightBlue
            addButton.btImageView.image = UIImage(named: "studentAdd")?.withRenderingMode(.alwaysOriginal)
            addButton.isHighlightedColor = UIColor.MyTheme.lightBlue.highlight
            addButton.btImageView.contentMode = .scaleAspectFit
            addButton.shadowColor = UIColor.MyTheme.lightBlue
        case .group:
            imageView.image = UIImage(named: "groupGreen")?.withRenderingMode(.alwaysOriginal)
            imageViewTitle.textColor = UIColor.MyTheme.lightGreen
            imageViewTitle.text = StudentOrGroup.group.rawValue
            counterLabel.textColor = UIColor.MyTheme.lightGreen
            addButton.btImageView.image = UIImage(named: "groupAdd")?.withRenderingMode(.alwaysOriginal)
            addButton.isHighlightedColor = UIColor.MyTheme.lightGreen.highlight
            addButton.btImageView.contentMode = .scaleToFill
            addButton.shadowColor = UIColor.MyTheme.lightGreen
        }
    }
    
    
    private func setupView(kind:StudentOrGroup) {
        //add to views to stuck
        stackView.addArrangedSubview(leftContainer)
        stackView.addArrangedSubview(centerContainer)
        stackView.addArrangedSubview(rightContainer)
        addSubview(stackView)
        
        //constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: stackView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: stackView)
        
        
        //additional setups
        setupCenterContainer()
        setupLeftContainer()
        setupRightContainer()
        
        
        //handle if it's student or group view
        handleKind(kind)
    }
    
   private let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
   private let imageViewTitle:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    
   private func setupLeftContainer() {
        
    //font
    imageViewTitle.font = UIFont.systemFont(ofSize: padding / 1.75)
    
    
    //layout
    leftContainer.addSubview(imageView)
    leftContainer.addSubview(imageViewTitle)
    
    leftContainer.addConstraintsWithFormat(format: "H:|-\(padding)-[v0]-\(padding)-|", views: imageView)
    leftContainer.addConstraintsWithFormat(format: "H:|[v0]|", views: imageViewTitle)
    leftContainer.addConstraintsWithFormat(format: "V:|-\(padding)-[v0(\(padding))]-2-[v1]-\(padding)-|", views: imageView,imageViewTitle)
    
    
    }
    
    private let counterLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "0"
        return label
    }()
    
    private let addButton:RoundButtonWithIcon = {
        let button = RoundButtonWithIcon(frame:.zero)
        return button
    }()
    
   private func setupCenterContainer() {
        
        //Font
          counterLabel.font = UIFont.systemFont(ofSize: padding,weight: .semibold)
        
        //Layout
        centerContainer.addSubview(counterLabel)
        centerContainer.addConstraint(NSLayoutConstraint(item: counterLabel, attribute: .centerX, relatedBy: .equal, toItem: centerContainer, attribute: .centerX, multiplier: 1, constant: 0))
        centerContainer.addConstraint(NSLayoutConstraint(item: counterLabel, attribute: .centerY, relatedBy: .equal, toItem: centerContainer, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    
    private func setupRightContainer() {
         print("Padding:\(padding)")

        
        //Layout
        rightContainer.addSubview(addButton)
        
        rightContainer.addConstraintsWithFormat(format: "H:[v0(\(padding * 2))]", views: addButton)
        rightContainer.addConstraintsWithFormat(format: "V:|-\(padding/1.1)-[v0(\(padding * 2))]", views: addButton)

        rightContainer.addConstraint(NSLayoutConstraint(item: addButton, attribute: .centerX, relatedBy: .equal, toItem: rightContainer, attribute: .centerX, multiplier: 1, constant: 0))
        
    }
    
    
}

