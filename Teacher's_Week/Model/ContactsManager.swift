//
//  Contacts.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 21/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation




struct ContactsManager:CollectionListData {
    
    static func getSectionsInfo() -> [SectionInfo] {
        
        let contacts = ContactsManager.getContacts()  //[Character:[Student]
            //sectionInfo
            let sectionsInfo:[SectionInfo] = {
                let sections = contacts.map { (contactsPerKey) -> SectionInfo in
                    
                    let headerTitle = contactsPerKey.key
                    
                    let cellsInfo:[CellInfo] = contactsPerKey.value.map { (contactsInKey) -> CellInfo in
                        let cellInfo = CellInfo(title:contactsInKey.name, subtitle: "subtitle",isAccessory:contactsInKey.checked)
                        return cellInfo
                    }
                    
                    let section = SectionInfo(headerTitle:String(headerTitle),cellsInfo:cellsInfo)
                    return section
                }
                return sections
            }()

           return sectionsInfo
        }
    
    static func filterSectionsInfoByText(sectionsInfo:[SectionInfo],text:String)->[SectionInfo] {//TODO: Move to more appropriate struct then ContactManager
        var filteredSectionsInfo:[SectionInfo] = []
        sectionsInfo.forEach { (sectionInfo) in
            var filteredCells:[CellInfo] = []
             filteredCells = sectionInfo.cellsInfo.filter { (cellInfo) -> Bool in
                return cellInfo.title?.contains(text) ?? false
            }
            print("filteredCount:\(filteredCells.count)")
            guard  filteredCells.count != 0 else {return}
            let headerFilteredSection:String = String(filteredCells[0].title?.first ?? " ") 
            let filteredSectionInfo = SectionInfo(headerTitle: headerFilteredSection, cellsInfo: filteredCells)
            filteredSectionsInfo.append(filteredSectionInfo)
        }
        return filteredSectionsInfo
    }
    
    static func getContacts()->[Character:[Student]] {
        
              let contacts:[Character:[Student]] = [
                "A":[Student(name: "April Levin"),Student(name: "Arnold Shvartsneger")],
                "B":[Student(name: "Bob Marli"),Student(name: "Bon Jovi"),Student(name: "Ben Gurion")],
                "C":[Student(name: "Chris Brawn")],
                "M":[Student(name: "Mark Tsugenberg"),Student(name: "Messi")]
            ]
        
        return contacts
    }
    
    
}
