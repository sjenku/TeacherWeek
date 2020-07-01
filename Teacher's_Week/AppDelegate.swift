//
//  AppDelegate.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 14/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
    
    var window:UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        DeviceConfigurations.windowHeight = window?.frame.height ?? 0
        DeviceConfigurations.windowWidth = window?.frame.width ?? 0
        
        window?.makeKeyAndVisible()
        print("Hello World")
        window?.rootViewController = AppTabBarController()
        
        return true
    }


}
