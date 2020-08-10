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

struct NavProperties {
         var navTitle:String = ""
         var withRightBarButton:Bool = false
         var rightBarButtonStyle:UIBarButtonItem.SystemItem = .done
         var rightBarButtonActionTarget:Any?
         var rightBarButtonAction:Selector?
}

extension UINavigationController {
    
    convenience init(rootViewController:UIViewController,isSetConfigurations:Bool = false) {
        self.init(rootViewController:rootViewController)
        if isSetConfigurations {
            setConfigurations()
        }
    }
    
    //MARK: - Public Methods
 
    func setupNavigationWithStyle(navProperties:NavProperties,forController vc:UIViewController?) {

          //Set title
         vc?.title = navProperties.navTitle

            //In Case NavigationBar Have Right Button
        if navProperties.withRightBarButton {

            let rightBarButton = createBarButtonItemWithStyle(style: navProperties.rightBarButtonStyle,target: navProperties.rightBarButtonActionTarget, selector: navProperties.rightBarButtonAction)
            vc?.navigationController?.topViewController?.navigationItem.rightBarButtonItem = rightBarButton
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
        navigationBar.prefersLargeTitles = true
        
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
