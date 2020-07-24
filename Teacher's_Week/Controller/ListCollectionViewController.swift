//
//  ListCollectionViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 04/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class ListCollectionViewController:UIViewController {
    
    
    //MARK: - Properties
    
    private var info:[SectionInfo]?
    private var cellStyle:CellStyle?
    private var navStyle:NavigationControllerStyle?
    private var navTitle:String = ""
    private var withRightBarButton:Bool = false
    private var rightBarButtonStyle:UIBarButtonItem.SystemItem = .done
    private var rightBarButtonAction:()->() = {}
    
    lazy var searchController:UISearchController = {
        [unowned self] in
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        sc.searchResultsUpdater = self
        return sc
    }()
    
    lazy var listView:CustomListView = {
        let view = CustomListView(frame: .zero, info: self.info, style: self.cellStyle)
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
    //MARK: - Initialazation
    
    init(info:[SectionInfo]?,cellStyle:CellStyle?) {
        super.init(nibName: nil, bundle: nil)
        self.info = info
        self.cellStyle = cellStyle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationControllerAppearnce()
        setupSearchView()
        setSubviews()
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nav = navigationController as? CustomNavigationController {
            nav.navBarButtonsDelegate = self
            nav.navigationBar.isHidden = false
        }
        
    }
    
    //MARK: - Private Methods
    
    private func setupSearchView() {
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
      definesPresentationContext = true
    }
    
    private func setSubviews() {
        view.addSubview(listView)
    }

    private func setConstraints() {
        
       let constraints = [
        listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    private func setNavigationControllerAppearnce() {
        
        guard let nav = navigationController as? CustomNavigationController else {return}
        guard let safeNavStyle = navStyle else {return}
        
        nav.setupNavigationWithStyle(style: safeNavStyle, title: self.navTitle, withRightButton: self.withRightBarButton, rightButtonStyle: self.rightBarButtonStyle)
    }
    
    //MARK: - Public Methods
    public func setNavigationControllerProperties(style:NavigationControllerStyle,title:String = "",withRightButton:Bool = false,rightButtonStyle:UIBarButtonItem.SystemItem = .done,rightButtonAction:@escaping()->()) {
        self.navStyle = style
        self.navTitle = title
        self.withRightBarButton = withRightButton
        self.rightBarButtonStyle = rightButtonStyle
        self.rightBarButtonAction = rightButtonAction
        
    }
}

//MARK: - Extension NavigationBarButtonDelegate
extension ListCollectionViewController:NavigationBarButtonsDelegate {
    
    func handleBarButtonPressed() {
       rightBarButtonAction()
    }
    
}

//MARK: - Extension UISearchResultsUpdating
extension ListCollectionViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard searchController.searchBar.text != "" else {
            self.listView.updateInfo(ContactsManager.getSectionsInfo())
            return
            
        }
        
        let filteredInfo = ContactsManager.filterSectionsInfoByText(sectionsInfo: ContactsManager.getSectionsInfo() , text: searchController.searchBar.text ?? "")
        self.listView.updateInfo(filteredInfo)
    }
}
