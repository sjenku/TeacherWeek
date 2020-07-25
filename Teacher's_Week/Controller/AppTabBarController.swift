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
    
    
    private let chooseFromListController = UINavigationController(rootViewController: ChoosableListController(navigationTitle:"Students"))
    
    private let newGroupCollectionVC:UINavigationController = {
        let vc = NewGroupCollectionVC()
        let navVC = UINavigationController(rootViewController: vc)
//        navVC.setupNavigationWithStyle(style: .large, title: "New Group")
        return navVC
    }()
    
    private let newStudentCollectionVC:UINavigationController = {
        let vc = NewStudentCollectionVC()
        let navVC = UINavigationController(rootViewController: vc)
//        navVC.setupNavigationWithStyle(style: .large, title: "New Student")
        return navVC
    }()
    
    private let tmpVC:UINavigationController = {
        let vc = GenerateScheduleStepOneVC()
        let navVC = UINavigationController(rootViewController: vc)
//        navVC.setupNavigationWithStyle(style: .small, title: "Step 1/2")
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
        chooseFromListController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "schedule"), tag: 2)
        newGroupCollectionVC.tabBarItem = UITabBarItem(title: "Student", image: UIImage(named: "person"), tag: 3)
        tmpVC.tabBarItem = UITabBarItem(title: "Group", image: UIImage(named: "personAndPerson"), tag: 4)
        
        
        viewControllers = [homeViewController,chooseFromListController,newGroupCollectionVC,tmpVC]
        setViewControllers(viewControllers, animated: true)
        
        //Design
        tabBar.tintColor = UIColor.MyTheme.lightBlue
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.MyTheme.barsColor
        
    }
    
    

}
