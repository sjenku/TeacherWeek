//
//  ScheduleResultsUpperHalfView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class ScheduleResultsUpperHalfView:CustomView {
    
    
    private let infoView:ScheduleResultsInfoView = {
        let view = ScheduleResultsInfoView()
        return view
    }()
    
   private let greenButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checkmark.button"), for: .normal)
        return button
    }()
    
    private let redButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "x.button"), for: .normal)
        return button
    }()
    
    private lazy var buttonsStackContrainer:UIStackView = {
        [unowned self] in
        let sv = UIStackView(arrangedSubviews: [self.greenButton,self.redButton])
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    
    override func setupView() {
        super.setupView()
        setSubviews()
        setConstriants()
    }
    
    private func setSubviews() {
        addSubview(infoView)
        addSubview(buttonsStackContrainer)
    }
    
    private func setConstriants() {
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: infoView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: buttonsStackContrainer)
        
        let additionalConstraints = [
            infoView.topAnchor.constraint(equalTo: self.topAnchor),
            infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
        
        ]
        
        additionalConstraints.forEach {$0.isActive = true}
    }
}
