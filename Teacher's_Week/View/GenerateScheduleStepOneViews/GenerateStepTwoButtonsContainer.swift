//
//  GenerateStepTwoButtonsContainer.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 07/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GenerateStepTwoButtonsContainer:CustomView {
    
    let redView:UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let previousButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Previous", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
        return button
    }()

    let generateButton:GenerateSOTitleBTView = {
        let button = GenerateSOTitleBTView(title: "Generate", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
        return button
    }()

    lazy var previousGenerateButtonsSV:UIStackView = {
        [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.previousButton,self.generateButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()

    
    override func setupView() {
        super.setupView()
        
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        addSubview(redView)
        addSubview(previousGenerateButtonsSV)
        
    }
    
    private func setConstraints() {
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: previousGenerateButtonsSV)
        addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        addConstraintsWithFormat(format: "V:|[v0][v1(==v0)]|", views: redView,previousGenerateButtonsSV)
    }
    
    
    
}
