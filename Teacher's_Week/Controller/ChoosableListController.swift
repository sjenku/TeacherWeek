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
      
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let sectionsInfo = ContactsManager.getSectionsInfo()
        return ListCollectionView(frame: .zero, info: sectionsInfo,style: nil)
    }()
    
    private let doneButtonView:UIView = ChooseLabelDoneBTView(title: "Done", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
    private let searchController:UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return sc
    }()
    
    
    
    
   //MARK: - Private Methods
    private func setNavigationItem() {
        navigationController?.navigationItem.largeTitleDisplayMode = .always
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
