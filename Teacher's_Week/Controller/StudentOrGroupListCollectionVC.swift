//
//  StudentOrGroupListCollectionVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 10/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class StudentOrGroupListCollectionVC:ListCollectionViewController {
     init(kind:StudentOrGroup) {
        
        
        let cellStyle:CellStyle = kind == .student ? CellStyle.detailTitle : CellStyle.detailSubtitle
        let info:[SectionInfo] = kind == .student ? DataManager.getStudentsInFormatSectionsInfo() : DataManager.getGroupsInFormatSectionInfo()
        super.init(info: info, cellStyle: cellStyle, navStyle: .large, navigationProperties: nil)
        self.searchTo = kind == .student ? .students : .groups
        self.kind = kind
        
    }
    
    var kind:StudentOrGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create navigationRightBarButton
        let navProperties = NavProperties(navTitle: kind?.rawValue ?? "", withRightBarButton: true, rightBarButtonStyle: .add
            , rightBarButtonActionTarget: self, rightBarButtonAction: #selector(handleRightBarButton))
        navigationController?.setupNavigationWithStyle(navProperties: navProperties, forController: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func handleRightBarButton() {
        switch kind {
        case .student:
            handleAddStudentNavBarButtonPressed()
        case .group:
            print("Group")
        case .none:
            print("None")
        }
    }
    
    
   private func handleAddStudentNavBarButtonPressed() {
        
        let actionController:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        //Import Contacts
        let actionImportContacts = UIAlertAction(title: "Import From Contacts", style: .default) { (action) in
            let vc = ChoosableListController()
            let doneButtonAction = {
                //Add Checked Contacts to Students
                let checkedContacts = vc.checkedInFormOfSectionsInfo
                checkedContacts.forEach { (checkedSection) in
                    checkedSection.cellsInfo.forEach { (cellInfo) in
                        guard let contact = cellInfo.relatedTo as? Student else {return}
                        DataManager.addNewStudent(firstName: contact.firstName,lastName: contact.lastName,phoneNumber: contact.phoneNumber,eMail: contact.eMail)
                    }
                }
                //Reset 'Check' property in all contacts
                ContactsManager.shared.resetCheckingStatus()
                self.navigationController?.popViewController(animated: true)
            }
            vc.doneButtonAction = doneButtonAction
            vc.title = "Contacts"
            //Handle Contacts After Get Permission From The User
            let executeIfGranted = {
                let info = ContactsManager.shared.getSectionsInfo()
                vc.info = info
                vc.searchTo = .contacts
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            let executeIfNotGranted = {
                let alertController = UIAlertController(title: "Don't Have Permission", message: "Please Go To Settings In Your Phone, And Change Permission For Accessing To Contacts ", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(cancelAction)
                DispatchQueue.main.async {
                     self.present(alertController, animated: true, completion: nil)
                }
            }
            ContactsManager.shared.executeFunctionIfContactsGranted(executeFunctionGranted: executeIfGranted, executeFunctionNotGranted: executeIfNotGranted)
        }
        //Create Student
        let actionCreateNew = UIAlertAction(title: "Create New Student", style: .default) { (action) in
            let vc = NewStudentCollectionVC()
            vc.title = "New Student"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //Cancel
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) {[weak self] (action) in
            self?.dismiss(animated: true, completion: nil)
        }
        
        [actionImportContacts,actionCreateNew,actionCancel].forEach { (action) in
            actionController.addAction(action)
        }
        self.navigationController?.topViewController?.present(actionController, animated: true, completion: nil)
    }
    
}
