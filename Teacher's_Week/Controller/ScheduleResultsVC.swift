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
    
    private var schedule:ScheduleResultTable = ScheduleManager.schedulesFromStudentsAndGroups.first ?? ScheduleResultTable(lessons: [], profit: 0)
    
    
    private lazy var upperContainer:ScheduleResultsUpperContainerView = {
        let view = ScheduleResultsUpperContainerView()
        view.infoView.profit = self.schedule.profit
        view.infoView.lessons = self.schedule.lessons.count
        view.infoView.successProcentege = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var listView:ListCollectionView = {
        [unowned self] in
        let info:[SectionInfo]? = ScheduleManager.sectionInfoForScheduleResults()
        let list = ListCollectionView(frame: .zero, info: info, style: .subtitle)
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    

    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        view.addSubview(upperContainer)
        view.addSubview(listView)
    }
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: upperContainer)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: listView)
        
       let additionalConstraints = [
        upperContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        upperContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5 - (0.5 * 0.3)),
        
        listView.topAnchor.constraint(equalTo: upperContainer.bottomAnchor,constant: 20),
        listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        additionalConstraints.forEach {$0.isActive = true}
    }
   
    
}
