//
//  HomeViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 15/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class HomeViewController:UIViewController,HomeLowerContainerViewDelegate {
    

    
    func addScheduleButtonPressed() {
        let vc = ScrollVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addStudentButtonPressed() {
        let info = ContactsManager.getSectionsInfo()
        let vc = ListCollectionViewController(info: info, cellStyle: .title, navStyle: .largeSearch, navTitle: "Students", withRightBarButton: true,rightBarButtonStyle: .done)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
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
        homeView?.lowerContainer.delegate = self
        view.addSubview(homeView!)
        
    }
    

}
