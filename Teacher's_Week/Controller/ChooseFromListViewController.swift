//
//  ChooseFromListViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ChooseFromListViewController:UIViewController{
    
    
    //MARK: - Views
    private let labelView:CustomView = ChooseLabelView()
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
    
    
   //MARK: - Functions Related To View
   private func setupView() {
        
        view.backgroundColor = UIColor.MyTheme.darkBG
    
        setupNavigationController()

        view.addSubview(labelView)
        view.addSubview(centerContainer)
        view.addSubview(lowerContainer)
        
        setConstraints()
    }
    
    private func setConstraints() {

        //Horizontal and Height
        view.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: labelView)
        view.addConstraintsWithFormat(format: "V:|-[v0][v1]-4-[v2]-4-|", views: labelView,centerContainer,lowerContainer)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: centerContainer)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: lowerContainer)
    
        //labelView height
        view.addConstraint(NSLayoutConstraint(item: labelView, attribute: .height, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 1/8, constant: 0))
        //lowerContainerView height
        view.addConstraint(NSLayoutConstraint(item: lowerContainer, attribute: .height, relatedBy: .equal, toItem: labelView, attribute: .height, multiplier: 1, constant: 0))
        

    }
    
    
    private func setupNavigationController() {
        
        //to not mess the searchBar
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
