//
//  ListCollectionViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 04/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ListCollectionViewController:UIViewController {
    
    
    
    private var info:[SectionInfo]?
    private var cellStyle:CellStyle?
    
    lazy var listView:CustomListView = {
         let info:[SectionInfo] = ContactsManager.getSectionsInfo()
         let view = CustomListView(frame: .zero, info: self.info, style: self.cellStyle)
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
    
    
    init(info:[SectionInfo]?,style:CellStyle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.info = info
        self.cellStyle = style
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
        setConstraints()
        
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
