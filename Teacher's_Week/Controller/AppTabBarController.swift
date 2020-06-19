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
    private let homeViewController:HomeViewController = HomeViewController()
    private let chooseFromListController = UINavigationController(rootViewController: ChooseFromListViewController())
    
    
    //MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarController()
        
    }
    
    
    
    //MARK: - Private Functions
    
    private func setTabBarController() {
        //Controllers
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .green
        
        //TabBar-Items
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house"), tag: 1)
        chooseFromListController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "schedule"), tag: 2)
        vc3.tabBarItem = UITabBarItem(title: "Student", image: UIImage(named: "person"), tag: 3)
        vc4.tabBarItem = UITabBarItem(title: "Group", image: UIImage(named: "personAndPerson"), tag: 4)
        
        
        viewControllers = [homeViewController,chooseFromListController,vc3,vc4]
        setViewControllers(viewControllers, animated: true)
        
        //Design
        tabBar.tintColor = UIColor.MyTheme.lightBlue
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.MyTheme.barsColor
        
    }
    
    

}
