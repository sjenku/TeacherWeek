//
//  GenerateScheduleStepOneVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 05/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class GenerateScheduleStepOneVC:UIViewController {
    
    //MARK: - Properties
    
    private lazy var buttonsContainer:GenerateStepOneButtonsContainer = {
        let view = GenerateStepOneButtonsContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nextButton.button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        view.resetButton.button.addTarget(self, action: #selector(handleResetButton), for: .touchUpInside)
        view.addButtonStudent.addTarget(self, action: #selector(handleAddStudentBT), for: .touchUpInside)
        view.addButtonGroup.addTarget(self, action: #selector(handleAddGroupBT), for: .touchUpInside)
        view.backgroundColor = UIColor.MyTheme.lightBG
        return view
    }()
    
   private let infoContainer:GenerateStepOneInfoContainer = {
          let view = GenerateStepOneInfoContainer()
          return view
      }()
    

    //MARK: - OBJC Methods
    
    @objc private func handleNextButton() {
        let vc = GenerateScheduleStepTwoVC()
        vc.title = "Step 2/2"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleResetButton() {
        ScheduleManager.students.removeAll()
        ScheduleManager.groups.removeAll()
        setInfo()
    }
    
    @objc private func handleAddStudentBT() {
        let vc = ChoosableListController()
        let doneButtonAction = {
            //Add Checked Contacts to Students
            let checkedContacts = vc.checkedInFormOfSectionsInfo
            checkedContacts.forEach { (checkedSection) in
                checkedSection.cellsInfo.forEach { (cellInfo) in
                    guard let contact = cellInfo.relatedTo as? Student else {return}
                    ScheduleManager.students.append(contact)
                }
            }
            //Reset 'Check' property in all contacts
            DataManager.resetStudentsCheckedStatus()
            self.navigationController?.popViewController(animated: true)
        }
        vc.doneButtonAction = doneButtonAction
        vc.title = "Students"
        vc.info = DataManager.getStudentsInFormatSectionsInfo()
        vc.searchTo = .students
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleAddGroupBT() {
          let vc = ChoosableListController()
          let doneButtonAction = {
              //Add Checked Contacts to Students
              let checkedContacts = vc.checkedInFormOfSectionsInfo
              checkedContacts.forEach { (checkedSection) in
                  checkedSection.cellsInfo.forEach { (cellInfo) in
                      guard let group = cellInfo.relatedTo as? Group else {return}
                      ScheduleManager.groups.append(group)
                  }
              }
              //Reset 'Check' property in all contacts
              self.navigationController?.popViewController(animated: true)
          }
          vc.doneButtonAction = doneButtonAction
          vc.title = "Groups"
          vc.info = DataManager.getGroupsInFormatSectionInfo()
          vc.searchTo = .groups
          navigationController?.pushViewController(vc, animated: true)
       }
    
  
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Step 1/2"
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstriants()
        setInfo()
        setObservers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    //MARK: - Deinit
    deinit {
        print("[Deinit]:removeObservers")
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Private Methods
    private func setInfo() {
        infoContainer.studentsInfoView.numberLabel.text = String(ScheduleManager.students.count)
        infoContainer.groupsInfoView.numberLabel.text = String(ScheduleManager.groups.count)
    }
    
    private func setSubviews() {
        view.addSubview(buttonsContainer)
        view.addSubview(infoContainer)
    }
    
    private func setConstriants() {
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: buttonsContainer)
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: infoContainer)
        
        let additionalConstraints = [
            buttonsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsContainer.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.55),
            
            infoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoContainer.bottomAnchor.constraint(equalTo: buttonsContainer.topAnchor)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}

//MARK: - Extension - HandleNotificationCenter
extension GenerateScheduleStepOneVC {
    private func setObservers() {
        print("Create Observers")
        let studentKeyNotificationName = NotificationKeys.keyName(key: .updateStudentSchedule)
        let groupKeyNotificationName = NotificationKeys.keyName(key: .updateGroupSchedule)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationUpdateStudentSchedule), name: studentKeyNotificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationUpdateGroupSchedule), name: groupKeyNotificationName, object: nil)
        
    }
    
    @objc private func handleNotificationUpdateStudentSchedule() {
        print("Students Changed:\(ScheduleManager.students.count)")
        setInfo()
    }
    
    @objc private func handleNotificationUpdateGroupSchedule() {
        print("Groups Changed:\(ScheduleManager.groups.count)")
        setInfo()
    }
    
}
