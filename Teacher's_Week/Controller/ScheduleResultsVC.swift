//
//  ScheduleResultsVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

enum ScheduleAlgo {
    case maxProfit,bruteForce
}

class ScheduleResultsVC:UIViewController {
    
    //MARK: - Properties
    
    var scheduleAlgo:ScheduleAlgo = .bruteForce //.maxProfit is Default Case
    
    private lazy var schedules:[ScheduleResultTable] = {
        var sched:[ScheduleResultTable] = []
        switch (self.scheduleAlgo) {
                case .bruteForce:
                    print("BruteForce")
                    sched.append(contentsOf:ScheduleManager.allCombinationSchedules)
                    sched.sort {$0.lessons.count > $1.lessons.count}
                case .maxProfit:
                    sched.append(contentsOf: ScheduleManager.maxProfitSchedules)
            }
        maxPage = sched.count - 1
        return sched
    }()
    
    private var currentPage:Int = 0 {
        willSet {
            setArrowButtons(page: newValue)
        }
        didSet {
            listView.updateInfo(ScheduleManager.sectionInfoForScheduleResults(schedule: schedule))
            upperContainer.infoView.profit = schedule.profit
            upperContainer.infoView.lessons = schedule.lessons.count
            upperContainer.infoView.successProcentege = 100
        }
    }
    private var maxPage:Int = 0
    
    private var schedule:ScheduleResultTable {
        get {
            guard schedules.count != 0 else {return ScheduleResultTable(lessons: [], profit: 0)}
            return schedules[currentPage]
        }
    }
    
    private lazy var upperContainer:ScheduleResultsUpperContainerView = {
        let view = ScheduleResultsUpperContainerView()
        view.infoView.profit = self.schedule.profit
        view.infoView.lessons = self.schedule.lessons.count
        view.infoView.successProcentege = 100
        view.forwardArrowBT.addTarget(self, action: #selector(handleForwardBT), for: .touchUpInside)
        view.backArrowBT.addTarget(self, action: #selector(handleBackwardBT), for: .touchUpInside)
        view.greenButton.addTarget(self, action: #selector(handleGreenBT), for: .touchUpInside)
        view.redButton.addTarget(self, action: #selector(handleRedBT), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var listView:ListCollectionView = {
        [unowned self] in
        let info:[SectionInfo]? = ScheduleManager.sectionInfoForScheduleResults(schedule: self.schedule)
        let list = ListCollectionView(frame: .zero, info: info, style: .subtitle)
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    
    //MARK: - Private Functions
    private func setArrowButtons(page:Int) {
        if page == 0 {
            enableBT(bt: upperContainer.backArrowBT, enable: false)
        }
        if page == maxPage {
            enableBT(bt: upperContainer.forwardArrowBT, enable: false)
        }
        if page > 0 {
            enableBT(bt: upperContainer.backArrowBT, enable: true)
        }
        if page < maxPage {
            enableBT(bt: upperContainer.forwardArrowBT, enable: true)
        }
    }
    
    private func enableBT(bt:UIButton,enable:Bool) {
        if enable {
            bt.tintColor = UIColor.MyTheme.lightBlue
            bt.isEnabled = true
        } else {
            bt.tintColor = .gray
            bt.isEnabled = false
        }
    }
    
    //MARK: - OBJC
    @objc private func handleForwardBT(button:UIButton) {
        currentPage += 1
    }
    
    @objc private func handleBackwardBT(button:UIButton) {
        currentPage -= 1
    }

    @objc private func handleGreenBT() {
        let ac = createUIAlertAction()
        present(ac, animated: true, completion: nil)
    }
    
    
    private func createUIAlertAction()->UIAlertController {
        print("Save Action")
        let ac = UIAlertController(title: "Schedule Name", message: "", preferredStyle: .alert)
          ac.addTextField()
          ac.textFields![0].placeholder = "Schedule Name"
         let actionSave = UIAlertAction(title: "Save", style: .default) {[unowned self] (action) in
            guard self.schedules.count > 0 else {return}
            self.schedules[self.currentPage].name = ac.textFields![0].text!
            self.schedules[self.currentPage].createdAt = Date()
            DataManager.schedules.append(self.schedule)
        }
          let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          ac.addAction(actionSave)
          ac.addAction(actionCancel)
        return ac
    }
    
    
    @objc private func handleRedBT() {
        if currentPage == 0 && maxPage == 0{
            navigationController?.popViewController(animated: true)
        } else if currentPage == 0 {
            schedules.remove(at: currentPage)
            maxPage -= 1
            currentPage = 0
        } else {
            schedules.remove(at: currentPage)
            maxPage -= 1
            currentPage -= 1
        }
    }
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setArrowButtons(page: currentPage)
        
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
