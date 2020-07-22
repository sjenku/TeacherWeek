//
//  CustomNavigationController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

//MARK: - Enums

enum NavigationControllerStyle {
    case small
    case smallSearch
    case large
    case largeSearch
}

enum NavigationControllerRightButtonStyle {
    case add
    case done
    case edit
}

protocol NavigationBarButtonsDelegate:class {
    func handleBarButtonPressed(barButtonType:NavigationControllerRightButtonStyle)
}

class CustomNavigationController:UINavigationController {
  
    //MARK: - Initialazation
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        setConfigurations()
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    
    weak var navBarButtonsDelegate:NavigationBarButtonsDelegate?
    
    lazy var searchController:UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return sc
    }()
    
    //MARK: - Public Methods
    func setupNavigationWithStyle(style:NavigationControllerStyle,title:String,withRightButton:Bool = false,rightButtonStyle:NavigationControllerRightButtonStyle = .done) {
        
        //Set title
       topViewController?.navigationItem.title = title
        
        //In Case Search Bar
        if style == .smallSearch || style == .largeSearch {
                print("Create Search ")
                topViewController?.navigationItem.searchController = searchController
                topViewController?.navigationItem.hidesSearchBarWhenScrolling = false
                topViewController?.definesPresentationContext = true
        }
        
        //In Case It's Big Large Navigation
        if style == .large || style == .largeSearch {
            navigationBar.prefersLargeTitles = true
        }
        
        //In Case NavigationBar Have Right Button
        if withRightButton {
            
          let rightBarButton = createBarButtonItemWithStyle(rightButtonStyle)
            topViewController?.navigationItem.rightBarButtonItem = rightBarButton
        }
    }
    
    //MARK: - OBJC private Methods
    
    @objc private func handleBarButtonAdd() {
        guard let barButtonDelegate = navBarButtonsDelegate else {return}
        barButtonDelegate.handleBarButtonPressed(barButtonType: .add)
    }
    
    @objc private func handleBarButtonDone() {
        guard let barButtonDelegate = navBarButtonsDelegate else {return}
        barButtonDelegate.handleBarButtonPressed(barButtonType: .done)
    }
    
    @objc private func handleBarButtonEdit() {
        guard let barButtonDelegate = navBarButtonsDelegate else {return}
        barButtonDelegate.handleBarButtonPressed(barButtonType: .edit)
     }
    
    //MARK: - Private Methods
    private func createBarButtonItemWithStyle(_ style:NavigationControllerRightButtonStyle)->UIBarButtonItem {
        var barButton:UIBarButtonItem?
        switch style {
          case .add:
            barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBarButtonAdd))
          case .done:
            barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleBarButtonDone))
          case .edit:
            barButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleBarButtonEdit))
        }
        return barButton!
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



