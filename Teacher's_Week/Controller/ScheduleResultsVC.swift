//
//  ScheduleResultsVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ScheduleResultsVC:UIViewController {
    
    //MARK: - Properties
   private let upperHalf = ScheduleResultsUpperHalfView()
    
    
    private let listView:ListCollectionView = {
        let info:[SectionInfo]? = DataManager.getStudentsInFormatSectionsInfo()
        let list = ListCollectionView(frame: .zero, info: info, style: .subtitle)
        return list
    }()
    
    private lazy var stackViewContent:UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.upperHalf,self.listView])
        sv.translatesAutoresizingMaskIntoConstraints = true
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        view.addSubview(stackViewContent)
    }
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: stackViewContent)
        
        stackViewContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackViewContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
   
    
}
