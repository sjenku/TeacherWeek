//
//  NewGroupViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class NewGroupCollectionVC:UIViewController {
    
    
    //MARK: - Properties
    var group:Group = Group() {
        didSet {
            lowerContainer.info = group.students
        }
    }
    
    //MARK: - Views
    let lowerContainer:NewGroupLowerContrainerView = {
        let view = NewGroupLowerContrainerView()
        view.doneButton.button.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        return view
    }()
    
    
    lazy var upperContainer:NewGroupUpperContrainerView = {
        let view = NewGroupUpperContrainerView()
        view.addButton.circleButton.addTarget(self, action: #selector(handleAddStudentPressed), for: .touchUpInside)
        view.deleteButton.circleButton.addTarget(self, action: #selector(handleDeletePressed), for: .touchUpInside)
        return view
    }()
    
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setNavigationBar()
        setNavigationItem()
        setSubview()
        setConstriants()

    }
    
//MARK: - OBJC Methods
    @objc func handleAddStudentPressed() {
        print("Add Student Pressed") //TODO:Complete
        let vc = ChoosableListController()
        let doneButtonAction = {
            //Add Checked Contacts to Students
            let checkedContacts = vc.checkedInFormOfSectionsInfo
            checkedContacts.forEach { (checkedSection) in
                checkedSection.cellsInfo.forEach { (cellInfo) in
                    guard let student = cellInfo.relatedTo as? Student else {return}
                    self.group.students.append(student)
                }
            }
            
            DataManager.resetStudentsCheckedStatus()
            self.navigationController?.popViewController(animated: true)
        }
        vc.doneButtonAction = doneButtonAction
        vc.info = DataManager.getStudentsInFormatSectionsInfo()
        vc.title = "Students"
        vc.searchTo = .students
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleDeletePressed() {
        guard let selectedIndexs = lowerContainer.collectionView.indexPathsForSelectedItems else {return}
        guard let selectedIndex = selectedIndexs.first else {return}
        
        group.students.remove(at: selectedIndex.row)
    }
    
    @objc func handleDoneButton() {
        guard let groupName = upperContainer.textField.textField.text else {return}
        
        guard groupName != "" else {  //Check If Group Name Exist
            alertWithMessage(message: "You need to make sure that the group have a name")
            return
        }
        
        guard group.students.count != 0 else { //Check If Group That Will Be Created Have at least one student
            alertWithMessage(message: "The group should have at least one student")
           return
        }
      
        group.groupName = groupName
        DataManager.groups.append(group)
        navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - Private Functions
    private func setNavigationBar() {
        title = "New Group"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setNavigationItem() {
        navigationController?.topViewController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setSubview() {
        view.addSubview(upperContainer)
        view.addSubview(lowerContainer)
    }
    
    private func setConstriants() {
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: upperContainer)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerContainer)
        view.addConstraintsWithFormat(format: "V:|-[v0][v1]", views: upperContainer,lowerContainer)
        lowerContainer.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.2 + 16).isActive = true
        
        
        lowerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -8).isActive = true
        
    }
    
    
    

    
}



