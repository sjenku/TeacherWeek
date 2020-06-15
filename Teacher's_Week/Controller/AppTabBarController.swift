//
//  AppTabBarController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTabBarController()
        
    }
    
    
    
    func setTabBarController() {
        //Controllers
        let homeViewController = HomeViewController()
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .yellow
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .green
        
        //TabBar-Items
            homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house"), tag: 1)
            vc2.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "schedule"), tag: 2)
            vc3.tabBarItem = UITabBarItem(title: "Student", image: UIImage(named: "person"), tag: 3)
            vc4.tabBarItem = UITabBarItem(title: "Group", image: UIImage(named: "person.and.person"), tag: 4)

        
        viewControllers = [homeViewController,vc2,vc3,vc4]
        setViewControllers(viewControllers, animated: true)
        
        //Design
        tabBar.tintColor = UIColor.MyTheme.lightBlue
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.MyTheme.barsColor
        
        
    }
    
}
