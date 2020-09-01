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
        view.translatesAutoresizingMaskIntoConstraints = false
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
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 0
        return sv
    }()
    
     let backArrowBT:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "openArrowLeft")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = .purple
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
     let forwardArrowBT:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "openArrowRight")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = .green
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
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
        addSubview(infoView)
        addSubview(buttonsStackContrainer)
        addSubview(backArrowBT)
        addSubview(forwardArrowBT)
    }
    
    private func setConstriants() {
  
        let additionalConstraints = [

            infoView.topAnchor.constraint(equalTo: self.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            infoView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            infoView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.5),
            
            buttonsStackContrainer.topAnchor.constraint(equalTo: infoView.bottomAnchor,constant: 8),
            buttonsStackContrainer.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 42),
            buttonsStackContrainer.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -42),
            buttonsStackContrainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backArrowBT.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            backArrowBT.centerYAnchor.constraint(equalTo: buttonsStackContrainer.centerYAnchor),
            backArrowBT.heightAnchor.constraint(equalTo: buttonsStackContrainer.heightAnchor,multiplier: 1),
            backArrowBT.widthAnchor.constraint(equalTo: buttonsStackContrainer.widthAnchor,multiplier: 0.055),
            
            forwardArrowBT.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16),
            forwardArrowBT.centerYAnchor.constraint(equalTo: buttonsStackContrainer.centerYAnchor),
            forwardArrowBT.heightAnchor.constraint(equalTo: buttonsStackContrainer.heightAnchor,multiplier: 1),
            forwardArrowBT.widthAnchor.constraint(equalTo: buttonsStackContrainer.widthAnchor,multiplier: 0.055)
            
        
        ]
        
        additionalConstraints.forEach {$0.isActive = true}
    }
}
