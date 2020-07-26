//
//  Contacts.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 21/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation
import Contacts



struct ContactsManager {
    
    static private var contacts:[Student] {
        get {
           let store = CNContactStore()
            var contacts:[Student] = []
               store.requestAccess(for: .contacts) { (granted, error) in
                   if let err = error {
                       print("Error Access Contacts:\(err.localizedDescription)")
                   }
                   guard granted != false else {
                       print("Go To Settings And Change Access Settings For This App")
                       return
                       
                   }
                   let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey,CNContactFamilyNameKey] as [CNKeyDescriptor])
                   do {
                       try store.enumerateContacts(with: request) { (contact, pointer) in
                           let fullName = contact.givenName + " " + contact.familyName
                           contacts.append(Student(name: fullName))   //Add New Contact
                       }
                   } catch let err {
                       print("Fetch Error:\(err.localizedDescription)")
                   }
               }
            return contacts
        }
    }
    
    static func getSectionsInfo() -> [SectionInfo] {
        var sectionsInfo:[SectionInfo] = []
        var cellsInfo:[CellInfo] = []
        
        print("Contacts Total:\(contacts.count)")
        contacts.forEach { (student) in
            cellsInfo.append(CellInfo(title: student.name, subtitle: "someAbra", isAccessory: false))
        }
        sectionsInfo.append(SectionInfo(headerTitle: "A", cellsInfo: cellsInfo))
        
        
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
    
//
//    static func getContacts() {
//
//        print("Get Contacts")
//        let store = CNContactStore()
//
//        store.requestAccess(for: .contacts) { (granted, error) in
//            if let err = error {
//                print("Error Access Contacts:\(err.localizedDescription)")
//            }
//            guard granted != false else {
//                print("Go To Settings And Change Access Settings For This App")
//                return
//
//            }
//            let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey,CNContactFamilyNameKey] as [CNKeyDescriptor])
//            contacts.removeAll()
//            do {
//                try store.enumerateContacts(with: request) { (contact, pointer) in
//                    let fullName = contact.givenName + " " + contact.familyName
//                    contacts.append(Student(name: fullName))   //Add New Contact
//                }
//            } catch let err {
//                print("Fetch Error:\(err.localizedDescription)")
//            }
//        }
//
//    }
    
}


//    static func getContacts()->[Character:[Student]] {
//
//              let contacts:[Character:[Student]] = [
//                "A":[Student(name: "April Levin"),Student(name: "Arnold Shvartsneger")],
//                "B":[Student(name: "Bob Marli"),Student(name: "Bon Jovi"),Student(name: "Ben Gurion")],
//                "C":[Student(name: "Chris Brawn")],
//                "M":[Student(name: "Mark Tsugenberg"),Student(name: "Messi")]
//            ]
//
//        return contacts
//    }


//
//        let contacts = ContactsManager.getContacts()  //[Character:[Student]
//            //sectionInfo
//            let sectionsInfo:[SectionInfo] = {
//                let sections = contacts.map { (contactsPerKey) -> SectionInfo in
//
//                    let headerTitle = contactsPerKey.key
//
//                    let cellsInfo:[CellInfo] = contactsPerKey.value.map { (contactsInKey) -> CellInfo in
//                        let cellInfo = CellInfo(title:contactsInKey.name, subtitle: "subtitle",isAccessory:contactsInKey.checked)
//                        return cellInfo
//                    }
//
//                    let section = SectionInfo(headerTitle:String(headerTitle),cellsInfo:cellsInfo)
//                    return section
//                }
//                return sections
//            }()
