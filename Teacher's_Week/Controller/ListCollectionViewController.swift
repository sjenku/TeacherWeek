//
//  ListCollectionViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 04/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class ListCollectionViewController:UIViewController {
    
    
    //MARK: - Properties
    
    private var info:[SectionInfo]?
    private var cellStyle:CellStyle?
    private var navProperties:NavProperties?
    private var navStyle:NavigationControllerStyle? = .small
    
    private lazy var searchController:CustomSearchController = {
        [weak self] in
        let sc = CustomSearchController(searchResultsController: nil)
        sc.listViewToUpdate = self?.listView
        return sc
    }()
    
    lazy var listView:CustomListView = {
        let view = CustomListView(frame: .zero, info: self.info, style: self.cellStyle)
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
    //MARK: - Initialazation
    
    init(info:[SectionInfo]?,cellStyle:CellStyle?,navStyle:NavigationControllerStyle,navigationProperties:NavProperties?) {
        super.init(nibName: nil, bundle: nil)
        self.info = info
        self.cellStyle = cellStyle
        self.navProperties = navigationProperties
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchView()
        setSubviews()
        setConstraints()
        setNavigationItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IQKeyboardManager.shared.enable = false
        listView.updateInfo(DataManager.getStudentsInFormatSectionsInfo())
        navigationController?.navigationBar.isHidden = false
        guard let unwrappedNavProperties = navProperties else {return}
        navigationController?.setupNavigationWithStyle(navProperties: unwrappedNavProperties, forController: self)

    }
       
       override func viewWillDisappear(_ animated: Bool) {
           IQKeyboardManager.shared.enable = true
       }
    
    //MARK: - Private Methods
    
    private func setNavigationItem() {
        guard let style = self.navStyle else {return}
        navigationController?.navigationItem.largeTitleDisplayMode = (style == .large) ? .always : .never
    }
    
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
    
}
