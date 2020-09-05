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
    
    private var info:[SectionInfo]? {
        willSet {
            listView.updateInfo(newValue)
        }
    }
    private var cellStyle:CellStyle?
    private var navProperties:NavProperties?
    private var navStyle:NavigationControllerStyle? = .small
    private var activeSearch:Bool = true
    
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
    
    var prevIndex:IndexPath? //For deletion schedule lesson in schedules
    
    lazy var listView:CustomListView = {
        [unowned self] in
         let view = CustomListView(frame: .zero, info: self.info, style: self.cellStyle)
         view.selectionActionDelegate = self
         view.deletionCompletionActionDelegate = self
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
    //MARK: - Initialazation
    
    init(info:[SectionInfo]?,cellStyle:CellStyle?,navStyle:NavigationControllerStyle,navigationProperties:NavProperties?,searchC:Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.info = info
        self.cellStyle = cellStyle
        self.navProperties = navigationProperties
        self.activeSearch = searchC
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if activeSearch {
           setupSearchView()
        }
        
        setSubviews()
        setConstraints()
        setNavigationItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IQKeyboardManager.shared.enable = false
        setInfoWhenAppear()
        navigationController?.navigationBar.isHidden = false
        guard let unwrappedNavProperties = navProperties else {return}
        navigationController?.setupNavigationWithStyle(navProperties: unwrappedNavProperties, forController: self)

    }
       
       override func viewWillDisappear(_ animated: Bool) {
           IQKeyboardManager.shared.enable = true
        
           
       }
    
    //MARK: - Private Methods
    
    private func setInfoWhenAppear() {
        switch searchTo {
        case .students:
            info = DataManager.getStudentsInFormatSectionsInfo()
        case .groups:
            info = DataManager.getGroupsInFormatSectionInfo()
        case .schedules:
            info = DataManager.getScheudlesInFormatSectionInfo()
        case .contacts:
            info = ContactsManager.shared.getSectionsInfo()
        case .schedule:
            print("Scheudle")
        case .none:
            print("Nothing")
        }
    }
    
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
    func performSelectionOfCellAction(indexPath:IndexPath) {
        
        guard let _ = info else {return}
        guard let beforeTappedStatus = info?[indexPath.section].cellsInfo[indexPath.row].isAccessory else {return}
        
        if cellStyle == .detailTitle || cellStyle == .detailSubtitle {
            
            if searchTo == .students {
                guard let studentInfo = info![indexPath.section].cellsInfo[indexPath.row].relatedTo as? Student else {return}
                let vc = StudentInfoVC(firstName: studentInfo.firstName, lastName: studentInfo.lastName, phoneNumber: studentInfo.phoneNumber, eMail: studentInfo.eMail)
                navigationController?.pushViewController(vc, animated: true)
                
            } else if searchTo == .groups {
                let vc = GroupInfoVC()
                let chosenGroup:Group = DataManager.groups[indexPath.row]
                vc.group = chosenGroup
                navigationController?.pushViewController(vc, animated: true)
           
            } else if searchTo == .schedules {
                print("Tapped Scheudle Cell:\(DataManager.schedules[indexPath.row])")
                let schedule = DataManager.schedules[indexPath.row]
                let vc = ListCollectionViewController(info: ScheduleManager.sectionInfoForScheduleResults(schedule: schedule), cellStyle: .subtitle, navStyle: .large, navigationProperties: nil,searchC: false)
                vc.searchTo = .schedule
                vc.prevIndex = indexPath
                vc.title = schedule.name
                navigationController?.pushViewController(vc,animated: true)
            }
            
        } else {  //else handle cases of cellStyle that not detail
               //Update For View
            info![indexPath.section].cellsInfo[indexPath.row].isAccessory = !info![indexPath.section].cellsInfo[indexPath.row].isAccessory!
               
               //Update In Background
               let checked = !beforeTappedStatus
               let studentName = (info![indexPath.section].cellsInfo[indexPath.row].title ?? "").SpliteToTwoStrings()
               
               
               if searchTo == .students {
                DataManager.updateStudentCheckedStatus(firstName: studentName.0, lastName: studentName.1, checked: checked)
               } else if searchTo == .contacts {
                ContactsManager.shared.updateContactCheckedStatus(firstName: studentName.0, lastName: studentName.1, checked: checked)
               }
               listView.collectionView.reloadData()
            
        }
    }
}

//MARK: - DeletionCellActionDelegate
extension ListCollectionViewController:DeletionCellActionDelegate {
    func performDeletionCompletionCellAction(indexPath: IndexPath) {
        switch searchTo {
        case .students:
           DataManager.students.remove(at: indexPath.row)
           listView.updateInfo(DataManager.getStudentsInFormatSectionsInfo())
        case .groups:
           DataManager.groups.remove(at: indexPath.row)
           listView.updateInfo(DataManager.getGroupsInFormatSectionInfo())
        case .schedules:
            DataManager.schedules.remove(at: indexPath.row)
            listView.updateInfo(DataManager.getScheudlesInFormatSectionInfo())
        case .schedule:
            guard let safeIndex = prevIndex else {break}
            DataManager.schedules[safeIndex.row].lessons.remove(at: indexPath.row) //goes to scheudles and delete from there the lessons of safeIndex schedule.

            listView.updateInfo(ScheduleManager.sectionInfoForScheduleResults(schedule: DataManager.schedules[safeIndex.row]))
            
        default:
            break
        }
    }
    
    
}

