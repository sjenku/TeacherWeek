//
//  ChooseFromListViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ChooseFromListViewController:UIViewController{
    
    
    
   private let labelView:CustomView = ChooseLabelView()
    
    
//   private let centerContainer:UIView = {
//        let view = UIView()
//        view.backgroundColor = .yellow
//        return view
//    }()
//
   private let centerContainer:UICollectionView = ChooseCollectionListView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   private let lowerContainer:UIView = ChooseLabelDoneBTView()
    
    
    private let searchController:UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return sc
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    

   private func setupView() {
        
        view.backgroundColor = UIColor.MyTheme.darkBG
    
        setupNavigationController()

        view.addSubview(labelView)
        view.addSubview(centerContainer)
        view.addSubview(lowerContainer)
        
        setConstraints()
    }
    
    
    private func setConstraints() {
        let navHeight = navigationController?.navigationBar.frame.height ?? 0
        let searchHeight = searchController.searchBar.frame.height
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let heightWithOut_nav_search_tabbar = view.frame.height - navHeight - searchHeight - tabBarHeight
        
        let upperViewHeight = ((heightWithOut_nav_search_tabbar) * 1.5 / 5) / 2
        let lowerViewHeight = upperViewHeight * 1.2
        
        //Horizontal and Height
        view.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: labelView)
        view.addConstraintsWithFormat(format: "V:[v0(\(upperViewHeight))]", views: labelView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: centerContainer)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: lowerContainer)
        view.addConstraintsWithFormat(format: "V:[v0(\(lowerViewHeight))]", views: lowerContainer)
    
        //Vertical
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            centerContainer.topAnchor.constraint(equalTo: labelView.bottomAnchor),
            lowerContainer.topAnchor.constraint(equalTo: centerContainer.bottomAnchor),
            lowerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])

    }
    
    
    private func setupNavigationController() {
        
        //searchBar
        self.definesPresentationContext = true
        
        //navigation
        self.navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if #available(iOS 13.0, *) {
            
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.MyTheme.barsColor
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        } else {
            
            navigationController?.navigationBar.barTintColor = UIColor.MyTheme.barsColor
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    
 
}
