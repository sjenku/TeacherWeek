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
     
    
    //MARK:Manage ListCollectionViewController For 'add student button' from HomeVC
     func addStudentButtonPressed() {
         let info = ContactsManager.getSectionsInfo()
         let vc = ListCollectionViewController(info: info, cellStyle: .title)
         let navRightBarButtonAction = {
            
            let actionController:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            //Import Contacts
            let actionImportContacts = UIAlertAction(title: "Import From Contacts", style: .default) { (action) in
                print("Import From Contacts Pressed")
            }
            //Create Student
            let actionCreateNew = UIAlertAction(title: "Create New Student", style: .default) { (action) in
                let vc = NewStudentCollectionVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //Cancel
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) {[weak self] (action) in
                self?.dismiss(animated: true, completion: nil)
            }
        
            [actionImportContacts,actionCreateNew,actionCancel].forEach { (action) in
                actionController.addAction(action)
            }
            self.present(actionController, animated: true, completion: nil)
        }
        
//        navigationController?.setupNavigationWithStyle(style: .large, title: "Students", withRightButton: true, rightButtonStyle: .add,rightButtonAction: #selector(handleAddStudentNavBarButtonPressed))

        vc.setNavigationControllerProperties(style: .large, title: "Students", withRightButton: true, rightButtonStyle: .add,target:self, rightButtonAction: #selector(handleAddStudentNavBarButtonPressed))
        
         navigationController?.pushViewController(vc, animated: true)
         
     }
    
    @objc func handleAddStudentNavBarButtonPressed() {
        print("Hello World")
    }
}

