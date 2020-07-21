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
    
    lazy var listView:CustomListView = {
         let info:[SectionInfo] = ContactsManager.getSectionsInfo()
         let view = CustomListView(frame: .zero, info: self.info, style: self.cellStyle)
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
    //MARK: - Initialazation
    
    init(info:[SectionInfo]?,cellStyle:CellStyle?,navStyle:NavigationControllerStyle? = nil,navTitle:String = "") {
        super.init(nibName: nil, bundle: nil)
        
        self.info = info
        self.cellStyle = cellStyle
        self.navStyle = navStyle
        self.navTitle = navTitle
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationController()
    }
    
    //MARK: - Private Methods
    
    private func setNavigationController() {
        guard let nav = navigationController as? CustomNavigationController else {return}
        guard let navigationStyle = self.navStyle else {return}
        nav.setupNavigationWithStyle(style: navigationStyle, title: self.navTitle)
        nav.navigationBar.isHidden = false
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
