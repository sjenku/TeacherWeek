//
//  ExtensionNavigationController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 24/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

enum NavigationControllerStyle {
    case small
    case large
}


extension UINavigationController {
    
    convenience init(rootViewController:UIViewController,isSetConfigurations:Bool = false) {
        self.init(rootViewController:rootViewController)
        if isSetConfigurations {
            setConfigurations()
        }
    }
    
    //MARK: - Public Methods
 
    func setupNavigationWithStyle(style:NavigationControllerStyle,forController vc:UIViewController?,title:String,withRightButton:Bool = false,rightButtonStyle:UIBarButtonItem.SystemItem = .done,target:Any? = nil,rightButtonAction:Selector? = nil) {

          //Set title
          vc?.title = title

            //In Case It's Big Large Navigation
            navigationBar.prefersLargeTitles = style == .large ? true : false

            //In Case NavigationBar Have Right Button
            if withRightButton {

                let rightBarButton = createBarButtonItemWithStyle(style: rightButtonStyle,target: target, selector: rightButtonAction)
                vc?.navigationItem.rightBarButtonItem = rightBarButton
            }
        }
    
    //MARK: - OBJC private Methods
    
    
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
