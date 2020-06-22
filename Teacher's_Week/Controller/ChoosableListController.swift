//
//  ChoosableListController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ChoosableListController:UIViewController{
    
    
    //MARK: - Properties
    var navTitle:String = ""
    
    
    
    //MARK: - Init
    init(navigationTitle:String) {
        navTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    //MARK: - Views
    
    private let labelView:CustomView = ChooseLabelView()
    private let personsListCollectionView:ListCollectionView =  {
        let sectionsInfo = ContactsManager.getSectionsInfo()
        return ListCollectionView(frame: .zero, info: sectionsInfo)
    }()
    
    private let doneButtonView:UIView = ChooseLabelDoneBTView()
    private let searchController:UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return sc
    }()
    
    
    
    
   //MARK: - Functions Related To View
    
   private func setupView() {
        
        view.backgroundColor = UIColor.MyTheme.darkBG
    
        setupNavigationController()

        view.addSubview(labelView)
        view.addSubview(personsListCollectionView)
        view.addSubview(doneButtonView)
        
        setConstraints()
    }
    
    private func setConstraints() {

        //Horizontal and Height
        view.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: labelView)
        view.addConstraintsWithFormat(format: "V:|-[v0][v1]-[v2(==v0)]-|", views: labelView,personsListCollectionView,doneButtonView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: personsListCollectionView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: doneButtonView)
    
        //centerContainer
        view.addConstraint(NSLayoutConstraint(item: personsListCollectionView, attribute: .height, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 0.6, constant: 0))
        

    }
    
    
    private func setupNavigationController() {
        
        //to not mess the searchBar
        self.definesPresentationContext = true
        
        //navigation
        self.navigationItem.title = navTitle
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
