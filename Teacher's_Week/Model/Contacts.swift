//
//  Contacts.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 21/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation




struct Contacts:CollectionListData {
    
    static func getSectionsInfo() -> [SectionInfo] {
        
        let contacts = Contacts.getContacts()  //[Character:[Student]
            //sectionInfo
            let sectionsInfo:[SectionInfo] = {
                let sections = contacts.map { (contactsPerKey) -> SectionInfo in
                    
                    let headerTitle = contactsPerKey.key
                    
                    let cellsInfo:[CellInfo] = contactsPerKey.value.map { (contactsInKey) -> CellInfo in
                        let cellInfo = CellInfo(title:contactsInKey.name, subtitle: nil,isAccessory:contactsInKey.checked)
                        return cellInfo
                    }
                    
                    let section = SectionInfo(headerTitle:String(headerTitle),cellsInfo:cellsInfo)
                    return section
                }
                return sections
            }()

           return sectionsInfo
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
