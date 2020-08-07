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
    
    var searchTo:CustomSearchController.SearchTo? {
           willSet {
               searchController.searchTo = newValue
               listView.searchTo = newValue
           }
       }
    
    lazy var listView:CustomListView = {
        [unowned self] in
         let view = CustomListView(frame: .zero, info: self.info, style: self.cellStyle)
         view.selectionActionDelegate = self
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
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.topViewController?.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func unSetupSearchView() {
      navigationController?.topViewController?.navigationItem.searchController = nil
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

//MARK: - Extension SelectableCellActionDelegate
extension ListCollectionViewController:SelectableCellActionDelegate {
    func performSelectionOfCellAction(sectionIndex: Int, rowIndex: Int) {
        
        guard let _ = info else {return}
        guard let beforeTappedStatus = info?[sectionIndex].cellsInfo[rowIndex].isAccessory else {return}
        
        if cellStyle == .detailTitle || cellStyle == .detailSubtitle {
            
            if searchTo == .students {
                let vc = StudentInfoVC()
                navigationController?.setupNavigationWithStyle(navProperties: NavProperties(navTitle: info![sectionIndex].cellsInfo[rowIndex].title ?? "", withRightBarButton: false), forController: vc)
                navigationController?.pushViewController(vc, animated: true)
            }
            
        } else {  //else handle cases of cellStyle that not detail
               //Update For View
               info![sectionIndex].cellsInfo[rowIndex].isAccessory = !info![sectionIndex].cellsInfo[rowIndex].isAccessory!
               
               //Update In Background
               let checked = !beforeTappedStatus
               let studentName:String = info![sectionIndex].cellsInfo[rowIndex].title ?? ""
               
               if searchTo == .students {
                   DataManager.updateStudentCheckedStatus(name: studentName, checked: checked)
               } else if searchTo == .contacts {
                   ContactsManager.shared.updateContactCheckedStatus(name: studentName,checked: checked)
               }
               listView.collectionView.reloadData()
            
        }
    }
    
    
    
}
