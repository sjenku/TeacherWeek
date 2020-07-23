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
     
     func addStudentButtonPressed() {
         let info = ContactsManager.getSectionsInfo()
         let vc = ListCollectionViewController(info: info, cellStyle: .title)
         let navRightBarButtonAction = {
            print("Hello")
        }
        
         vc.setNavigationControllerProperties(style: .largeSearch, title: "Students", withRightButton: true, rightButtonStyle: .add,rightButtonAction: navRightBarButtonAction)
         
         navigationController?.pushViewController(vc, animated: true)
         
     }
}
