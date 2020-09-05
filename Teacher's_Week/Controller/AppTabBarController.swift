//
//  AppTabBarController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    //MARK: - Views
    private let homeViewController:UINavigationController =  {
        let vc = HomeViewController()
        let navVC = UINavigationController(rootViewController: vc, isSetConfigurations: true)
        return navVC
    }()
    
    private let savedScheduleVC:UINavigationController = {
        let vc = ListCollectionViewController(info: DataManager.getScheudlesInFormatSectionInfo(), cellStyle: .detailSubtitle, navStyle: .large, navigationProperties: nil)
        vc.searchTo = .schedules
        vc.title = "Saved Schedules"
        let nav = UINavigationController(rootViewController: vc, isSetConfigurations:true)
        return nav
    }()
    
    private let studentListVC:UINavigationController = {
       let vc = StudentOrGroupListCollectionVC(kind: .student)
       let navVC = UINavigationController(rootViewController: vc, isSetConfigurations: true)
       return navVC
    }()
    
    private let groupListVC:UINavigationController = {
        let vc = StudentOrGroupListCollectionVC(kind: .group)
        let navVC = UINavigationController(rootViewController: vc, isSetConfigurations:true)
        return navVC
      }()
    
    private let newStudentCollectionVC:UINavigationController = {
        let vc = NewStudentCollectionVC()
           let navVC = UINavigationController(rootViewController: vc, isSetConfigurations:true)
//        navVC.setupNavigationWithStyle(style: .large, title: "New Student")
        return navVC
    }()
    

    
    //MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarController()
        
    }
    
    
    
    //MARK: - Private Functions
    
    private func setTabBarController() {

        //TabBar-Items
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house"), tag: 1)
        savedScheduleVC.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "schedule"), tag: 2)
        studentListVC.tabBarItem = UITabBarItem(title: "Students", image: UIImage(named: "person"), tag: 3)
        groupListVC.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(named: "personAndPerson"), tag: 4)
        
        
        viewControllers = [homeViewController,savedScheduleVC,studentListVC,groupListVC]
        setViewControllers(viewControllers, animated: true)
        
        //Design
        tabBar.tintColor = UIColor.MyTheme.lightBlue
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.MyTheme.barsColor
        
    }
    
    

}
