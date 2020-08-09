//
//  HomeViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 15/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class HomeViewController:UIViewController{
    
    
    var homeView:HomeView?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        homeView?.lowerContainer.updateAddStudentViewCounter(number: DataManager.students.count)
        homeView?.lowerContainer.updateAddGroupViewCounter(number: DataManager.groups.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
   private func setupView () {
        
        
        let heightTabBar = tabBarController?.tabBar.frame.height ?? 0
        homeView = HomeView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - heightTabBar))
           homeView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeView!)
         [
            homeView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView?.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            homeView?.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ].forEach {$0?.isActive = true}
         
        homeView?.lowerContainer.delegate = self
        
    }

}

//MARK: - Extension HomeLowerContainerViewDelegate

extension HomeViewController:HomeLowerContainerViewDelegate {
    func addScheduleButtonPressed() {
         let vc = ScrollVC()
         navigationController?.pushViewController(vc, animated: true)
     }

 //MARK: - Manage ListCollectionViewController For 'add Group Button' that exist in HomeVC
    func addGroupButtonPressed() {
        let info = DataManager.getGroupsInFormatSectionInfo()
        let vc = ListCollectionViewController(info: info, cellStyle: .detailSubtitle, navStyle: .large, navigationProperties: NavProperties(navTitle: "Groups", withRightBarButton: true, rightBarButtonStyle: .add, rightBarButtonActionTarget: self, rightBarButtonAction: #selector(handleAddGroupNavBarButtonPressed)))
        vc.listView.isSelectable = true
        vc.searchTo = .groups
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleAddGroupNavBarButtonPressed() {
        let vc = NewGroupCollectionVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
//MARK: - Manage ListCollectionViewController For 'add student button' from HomeVC
     func addStudentButtonPressed() {
        let info = DataManager.getStudentsInFormatSectionsInfo()
        let vc = ListCollectionViewController(info: info, cellStyle: .detailTitle,navStyle: .large, navigationProperties:NavProperties(navTitle: "Students", withRightBarButton: true, rightBarButtonStyle: .add, rightBarButtonActionTarget: self, rightBarButtonAction: #selector(handleAddStudentNavBarButtonPressed)))
        
         vc.listView.isSelectable = true
         vc.searchTo = .students
         navigationController?.pushViewController(vc, animated: true)
         
     }
    
    @objc func handleAddStudentNavBarButtonPressed() {
        
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

