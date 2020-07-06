//
//  GenerateStepOneButtonsContainer.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 05/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GenerateStepOneButtonsContainer:CustomView {
    
    let resetButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Reset", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
        return button
    }()
    
    let nextButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Next", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
           return button
    }()
    
    let addButtonStudent:RectButtonWithImgTitle = {
        let button = RectButtonWithImgTitle()
        button.backgroundColor = UIColor.MyTheme.darkBG
        button.notHighlightedColor = UIColor.MyTheme.darkBG
        button.highlightedColor = UIColor.MyTheme.lightBlue.highlight
        button.btImageView.image = UIImage(named: "studentAdd")?.withRenderingMode(.alwaysOriginal)
        button.btTitle.text = "Add Student To Schedule"
        button.btTitle.textAlignment = .center
        button.btTitle.textColor = UIColor.MyTheme.lightBlue
        return button
    }()
    
    let addButtonGroup:RectButtonWithImgTitle = {
       let button = RectButtonWithImgTitle()
        button.backgroundColor = UIColor.MyTheme.darkBG
        button.notHighlightedColor = UIColor.MyTheme.darkBG
        button.highlightedColor = UIColor.MyTheme.lightGreen.highlight
        button.btImageView.image = UIImage(named: "groupAdd")?.withRenderingMode(.alwaysOriginal)
        button.btTitle.text = "Add Group To Schedule"
        button.btTitle.textAlignment = .center
        button.btTitle.textColor = UIColor.MyTheme.lightGreen
        return button
    }()
    
    lazy var resetNextButtonsSV:UIStackView = {
        [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.resetButton,self.nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var addStudentGroupButtonsSV:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.addButtonStudent,self.addButtonGroup])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let line:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        setSubviews()
        setConstraints()
    }
    
    
    private func setSubviews() {
        addSubview(resetNextButtonsSV)
        addSubview(line)
        addSubview(addStudentGroupButtonsSV)
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: resetNextButtonsSV)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: line)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: addStudentGroupButtonsSV)
        
        
        
        let additionalConstraints = [
        resetNextButtonsSV.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8),
        resetNextButtonsSV.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1),
            
        line.bottomAnchor.constraint(equalTo: resetNextButtonsSV.topAnchor,constant: -8),
        line.heightAnchor.constraint(equalToConstant: 0.5),
        
        addStudentGroupButtonsSV.topAnchor.constraint(equalTo: self.topAnchor,constant: 24),
        addStudentGroupButtonsSV.bottomAnchor.constraint(equalTo: line.topAnchor,constant: -24)
        
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
