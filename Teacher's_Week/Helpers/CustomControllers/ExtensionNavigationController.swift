//
//  ExtensionNavigationController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 24/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

//protocol NavigationBarButtonsDelegate:NSObject,UINavigationControllerDelegate {
//    func handleBarButtonPressed()
//}


extension UINavigationController {
    
    convenience init(style:NavigationControllerStyle,
                     rootViewController:UIViewController,
                     title:String,
                     withBarButton:Bool = false,
                     barButtonStyle:UIBarButtonItem.SystemItem = .done) {
        self.init(rootViewController:rootViewController)
        
        setConfigurations()
        setupNavigationWithStyle(style: style, title: title, withRightButton: withBarButton, rightButtonStyle: barButtonStyle)
    }
    
    
    
    //MARK: - Public Methods
    
    func setupNavigationWithStyle(style:NavigationControllerStyle,title:String,withRightButton:Bool = false,rightButtonStyle:UIBarButtonItem.SystemItem = .done,target:Any? = nil,rightButtonAction:Selector? = nil) {
            
            //Set title
          topViewController?.title = title
            
            //In Case It's Big Large Navigation
            navigationBar.prefersLargeTitles = style == .large ? true : false

            //In Case NavigationBar Have Right Button
            if withRightButton {
                
                let rightBarButton = createBarButtonItemWithStyle(style: rightButtonStyle,target: target, selector: rightButtonAction)
                topViewController?.navigationItem.rightBarButtonItem = rightBarButton
            }
        }
    
    //MARK: - OBJC private Methods
    
//    @objc private func handleBarButton() {
//        guard let safeDelegate = delegate as? NavigationBarButtonsDelegate else {return}
//        safeDelegate.handleBarButtonPressed()
//    }
    
    //MARK: - Private Methods
    
    private func createBarButtonItemWithStyle(style:UIBarButtonItem.SystemItem,target:Any? = nil,selector:Selector? = nil)->UIBarButtonItem {
        let barButton = UIBarButtonItem(barButtonSystemItem: style, target: target, action: selector)
          return barButton
      }
    
    private func setConfigurations() {
        //For All Cases Configurations
        if #available(iOS 13.0, *) {
            
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.MyTheme.barsColor
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
            
        } else {
            
            navigationBar.barTintColor = UIColor.MyTheme.barsColor
            navigationBar.isTranslucent = false
            navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    
}
