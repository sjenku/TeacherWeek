//
//  ChoosableListController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChoosableListController:UIViewController{
      
   //MARK: - Properties
    var info:[SectionInfo] {
        set {
            self.personsListCollectionView.updateInfo(newValue)
        }
        get {
            self.personsListCollectionView.getCurrentInfoInList()
        }
    }
    
    var checkedInFormOfSectionsInfo:[SectionInfo] {
        get {
            var sectionsInfoFiltered:[SectionInfo] = []
            info.forEach { (sectionInfo) in
             let cellsInfoForSectionFiltered = sectionInfo.cellsInfo.filter{$0.isAccessory ?? false}
                sectionsInfoFiltered.append(SectionInfo(headerTitle: sectionInfo.headerTitle, cellsInfo: cellsInfoForSectionFiltered))
            }
            return sectionsInfoFiltered
        }
    }
    
    var searchTo:CustomSearchController.SearchTo? {
        willSet {
            searchController.searchTo = newValue
            personsListCollectionView.searchTo = newValue
        }
    }
    var doneButtonAction:(()->Void)?
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchView()
        setNavigationItem()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = true
    }
    
    
    //MARK: - Views
    
    private let labelView:CustomView = ChooseLabelView()
    private let personsListCollectionView:ListCollectionView =  {
        return ListCollectionView(frame: .zero, info: nil,style: nil)
    }()
    
    private let doneButtonView:UIView = {
     let btView = ChooseLabelDoneBTView(title: "Done", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
        btView.button.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
     return btView
    }()
    
    private lazy var searchController:CustomSearchController = {
        [weak self] in
        let sc = CustomSearchController(searchResultsController:nil)
        sc.listViewToUpdate = self?.personsListCollectionView
        return sc
    }()
    
    
    //MARK: - OBJC Methods
    @objc private func handleDoneButton() {
        guard let doneBTAction = doneButtonAction else {return}
        doneBTAction()
    }
    
   //MARK: - Private Methods
    
    private func setNavigationItem() {
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupSearchView() {

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
       navigationItem.searchController = searchController
       navigationItem.hidesSearchBarWhenScrolling = false
       definesPresentationContext = true
     }
    
    private func unSetupSearchView() {
           navigationItem.searchController = nil
       }
       
    
   private func setupView() {
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        view.addSubview(labelView)
        view.addSubview(personsListCollectionView)
        view.addSubview(doneButtonView)
        
        setConstraints()
    }
    
 
    private func setConstraints() {

        //Horizontal and Vertical
        view.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: labelView)
        view.addConstraintsWithFormat(format: "V:|-[v0][v1]-[v2(==v0)]", views: labelView,personsListCollectionView,doneButtonView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: personsListCollectionView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: doneButtonView)
        
        //labelView Height
        labelView.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1).isActive = true
        doneButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -8).isActive = true

    }
    
    
}
