//
//  ScheduleResultsUpperHalfView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class ScheduleResultsUpperContainerView:CustomView {
    
    
    let infoView:ScheduleResultsInfoView = {
        let view = ScheduleResultsInfoView()
        return view
    }()
    
    private let greenButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "acceptButton"), for: .normal)
        return button
    }()
    
    
    private let redButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "x.button"), for: .normal)
        return button
    }()
    
    private lazy var buttonsStackContrainer:UIStackView = {
        [unowned self] in
        let sv = UIStackView(arrangedSubviews: [self.greenButton,self.redButton])
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = -50
        return sv
    }()
    
    private let tmpButton:UIButton = {
        let bt = UIButton()
        bt.backgroundColor = UIColor.MyTheme.darkBG
        return bt
    }()
    
    private let backArrowBT:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "openArrowLeft"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    private let forwardArrowBT:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "openArrowRight"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    private lazy var verticalContainerStack:UIStackView = {
        [unowned self ] in
        let sv = UIStackView(arrangedSubviews: [self.infoView,self.buttonsStackContrainer])
        sv.distribution = .fillEqually
        sv.spacing = 16
        sv.axis = .vertical
        return sv
    }()
    
    override func setupView() {
        super.setupView()
        setButtonsContent()
        setSubviews()
        setConstriants()
    }
    
    private func setButtonsContent() {
        [greenButton,redButton,backArrowBT,forwardArrowBT].forEach {
            $0.imageView?.contentMode = .scaleAspectFit
            $0.contentVerticalAlignment = .fill
            $0.contentHorizontalAlignment = .fill
        }
    }
    
    private func setSubviews() {
        addSubview(verticalContainerStack)
        addSubview(backArrowBT)
        addSubview(forwardArrowBT)
    }
    
    private func setConstriants() {
//        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: infoView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: verticalContainerStack)
        
        let additionalConstraints = [
            verticalContainerStack.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            verticalContainerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backArrowBT.leadingAnchor.constraint(equalTo: buttonsStackContrainer.leadingAnchor),
            backArrowBT.centerYAnchor.constraint(equalTo: buttonsStackContrainer.centerYAnchor),
            backArrowBT.heightAnchor.constraint(equalTo: buttonsStackContrainer.heightAnchor,multiplier: 1),
            backArrowBT.widthAnchor.constraint(equalTo: buttonsStackContrainer.widthAnchor,multiplier: 0.055),
            
            forwardArrowBT.rightAnchor.constraint(equalTo: buttonsStackContrainer.rightAnchor),
            forwardArrowBT.centerYAnchor.constraint(equalTo: buttonsStackContrainer.centerYAnchor),
            forwardArrowBT.heightAnchor.constraint(equalTo: buttonsStackContrainer.heightAnchor,multiplier: 1),
            forwardArrowBT.widthAnchor.constraint(equalTo: buttonsStackContrainer.widthAnchor,multiplier: 0.055)
            
        
        ]
        
        additionalConstraints.forEach {$0.isActive = true}
    }
}
