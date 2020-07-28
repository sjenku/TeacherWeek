//
//  CustomSearchController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 27/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class CustomSearchController:UISearchController {

    enum SearchTo {
        case students,contacts,groups
    }
    
    var listViewToUpdate:CustomListView?
    var searchTo:SearchTo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupSearchController()
    }
    
    private func setupSearchController() {
        searchBar.tintColor = UIColor.white
        obscuresBackgroundDuringPresentation = false
        searchResultsUpdater = self
        delegate = self
    }
}


//
////MARK: - Extension UISearchResultsUpdating
extension CustomSearchController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        var info:[SectionInfo] = []
        
        switch searchTo {
        case .students:
            info = DataManager.getStudentsInFormatSectionsInfo()
        case .contacts:
            info = ContactsManager.getSectionsInfo()
        default:
            info = []
        }
        
        guard searchController.searchBar.text != "" else {
            self.listViewToUpdate?.updateInfo(info)
            return
        }

        let filteredInfo = DataManager.filterSectionsInfoByText(sectionsInfo: info , text: searchController.searchBar.text ?? "")
        self.listViewToUpdate?.updateInfo(filteredInfo)

    }
}
//
extension CustomSearchController:UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        //Add Checked Student To Data
        guard let listView = listViewToUpdate else {return}
        let contactsInSearchControllerInSections = listView.getCurrentInfoInList()
        var cells:[CellInfo] = []
        contactsInSearchControllerInSections.forEach { (sectionInfo) in
            cells.append(contentsOf: sectionInfo.cellsInfo)
        }
            //TODO:Create More Efficiant way to find student and update
            cells.forEach { (cellInfo) in
               let studentIndex = DataManager.students.firstIndex { (student) -> Bool in
                    student.name == cellInfo.title
                }
                if let index = studentIndex {
                    DataManager.students[index].checked = cellInfo.isAccessory ?? false
                }
            }
        }
}
